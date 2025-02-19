//! Objective-C's @throw and @try/@catch.
//!
//! By default, if the [`msg_send!`] macro causes an exception to be thrown,
//! this will unwind into Rust, resulting in undefined behavior. However, this
//! crate has an `"catch-all"` feature which, when enabled, wraps each
//! [`msg_send!`] in a `@catch` and panics if an exception is caught,
//! preventing Objective-C from unwinding into Rust.
//!
//! The `@try`/`@catch` functionality in this module is only available when
//! the `"exception"` feature is enabled.
//!
//! See the following links for more information:
//! - [Exception Programming Topics for Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html)
//! - [The Objective-C Programming Language - Exception Handling](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocExceptionHandling.html)
//! - [Exception Handling in LLVM](https://llvm.org/docs/ExceptionHandling.html)
//!
//! [`msg_send!`]: crate::msg_send

// TODO: Test this with panic=abort, and ensure that the code-size is
// reasonable in that case.

#[cfg(feature = "exception")]
use core::ffi::c_void;
use core::fmt;
#[cfg(feature = "exception")]
use core::mem;
use core::ops::Deref;
use core::panic::RefUnwindSafe;
use core::panic::UnwindSafe;
#[cfg(feature = "exception")]
use core::ptr;
use std::error::Error;

use crate::encode::{Encoding, RefEncode};
#[cfg(feature = "exception")]
use crate::ffi;
use crate::rc::{autoreleasepool_leaking, Id};
use crate::runtime::__nsstring::nsstring_to_str;
use crate::runtime::{Class, NSObject, NSObjectProtocol, Object};
use crate::{extern_methods, sel, Message};

/// An Objective-C exception.
///
/// While highly recommended that any exceptions you intend to throw are
/// subclasses of `NSException`, this is not required by the runtime (similar
/// to how Rust can panic with arbitary payloads using [`panic_any`]).
///
/// [`panic_any`]: std::panic::panic_any
#[repr(transparent)]
pub struct Exception(Object);

unsafe impl RefEncode for Exception {
    const ENCODING_REF: Encoding = Encoding::Object;
}

unsafe impl Message for Exception {}

impl Deref for Exception {
    type Target = Object;

    #[inline]
    fn deref(&self) -> &Object {
        &self.0
    }
}

impl AsRef<Object> for Exception {
    #[inline]
    fn as_ref(&self) -> &Object {
        self
    }
}

impl Exception {
    fn is_nsexception(&self) -> Option<bool> {
        if self.class().responds_to(sel!(isKindOfClass:)) {
            // SAFETY: We only use `isKindOfClass:` on NSObject
            let obj: *const Exception = self;
            let obj = unsafe { obj.cast::<NSObject>().as_ref().unwrap() };
            // Get class dynamically instead of with `class!` macro
            Some(obj.__isKindOfClass(Class::get("NSException")?))
        } else {
            Some(false)
        }
    }
}

extern_methods!(
    unsafe impl Exception {
        // Only safe on NSException
        // Returns NSString
        #[method_id(name)]
        unsafe fn name(&self) -> Option<Id<NSObject>>;

        // Only safe on NSException
        // Returns NSString
        #[method_id(reason)]
        unsafe fn reason(&self) -> Option<Id<NSObject>>;
    }
);

// Note: We can't implement `Send` nor `Sync` since the exception could be
// anything!

impl fmt::Debug for Exception {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "exception ")?;

        // Attempt to present a somewhat usable error message if the exception
        // is an instance of NSException.
        if let Some(true) = self.is_nsexception() {
            autoreleasepool_leaking(|pool| {
                // SAFETY: Just checked that object is an NSException
                let (name, reason) = unsafe { (self.name(), self.reason()) };

                // SAFETY: `name` and `reason` are guaranteed to be NSString.
                let name = name
                    .as_deref()
                    .map(|name| unsafe { nsstring_to_str(name, pool) });
                let reason = reason
                    .as_deref()
                    .map(|reason| unsafe { nsstring_to_str(reason, pool) });

                let obj: &Object = self.as_ref();
                write!(f, "{obj:?} '{}'", name.unwrap_or_default())?;
                if let Some(reason) = reason {
                    write!(f, " reason:{reason}")?;
                } else {
                    write!(f, " reason:(NULL)")?;
                }
                Ok(())
            })
        } else {
            // Fall back to `Object` Debug
            write!(f, "{:?}", self.0)
        }
    }
}

impl fmt::Display for Exception {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        autoreleasepool_leaking(|pool| {
            if let Some(true) = self.is_nsexception() {
                // SAFETY: Just checked that object is an NSException
                let reason = unsafe { self.reason() };

                if let Some(reason) = &reason {
                    // SAFETY: `reason` is guaranteed to be NSString.
                    let reason = unsafe { nsstring_to_str(reason, pool) };
                    return write!(f, "{reason}");
                }
            }

            write!(f, "unknown exception")
        })
    }
}

impl Error for Exception {}

impl UnwindSafe for Exception {}
impl RefUnwindSafe for Exception {}

/// Throws an Objective-C exception.
///
/// This is the Objective-C equivalent of Rust's [`panic!`].
///
///
/// # Safety
///
/// This unwinds from Objective-C, and the exception must be caught using an
/// Objective-C exception handler like [`catch`] (and specifically not
/// [`catch_unwind`]).
///
/// This also invokes undefined behaviour until `C-unwind` is stabilized, see
/// [RFC-2945] - you can try this out on nightly using the `unstable-c-unwind`
/// feature flag.
///
/// [`catch_unwind`]: std::panic::catch_unwind
/// [RFC-2945]: https://rust-lang.github.io/rfcs/2945-c-unwind-abi.html
#[inline]
#[cfg(feature = "exception")] // For consistency, not strictly required
pub unsafe fn throw(exception: Id<Exception>) -> ! {
    let ptr = exception.0.as_ptr() as *mut ffi::objc_object;
    // SAFETY: Object is valid and non-null (nil exceptions are not valid in
    // the old runtime).
    unsafe { ffi::objc_exception_throw(ptr) }
}

#[cfg(feature = "exception")]
unsafe fn try_no_ret<F: FnOnce()>(closure: F) -> Result<(), Option<Id<Exception>>> {
    #[cfg(not(feature = "unstable-c-unwind"))]
    let f = {
        extern "C" fn try_objc_execute_closure<F>(closure: &mut Option<F>)
        where
            F: FnOnce(),
        {
            // This is always passed Some, so it's safe to unwrap
            let closure = closure.take().unwrap();
            closure();
        }

        let f: extern "C" fn(&mut Option<F>) = try_objc_execute_closure;
        let f: extern "C" fn(*mut c_void) = unsafe { mem::transmute(f) };
        f
    };

    #[cfg(feature = "unstable-c-unwind")]
    let f = {
        extern "C-unwind" fn try_objc_execute_closure<F>(closure: &mut Option<F>)
        where
            F: FnOnce(),
        {
            // This is always passed Some, so it's safe to unwrap
            let closure = closure.take().unwrap();
            closure();
        }

        let f: extern "C-unwind" fn(&mut Option<F>) = try_objc_execute_closure;
        let f: extern "C-unwind" fn(*mut c_void) = unsafe { mem::transmute(f) };
        f
    };

    // Wrap the closure in an Option so it can be taken
    let mut closure = Some(closure);
    let context: *mut Option<F> = &mut closure;
    let context = context.cast();

    let mut exception = ptr::null_mut();
    let success = unsafe { ffi::try_catch(f, context, &mut exception) };

    if success == 0 {
        Ok(())
    } else {
        // SAFETY:
        // The exception is always a valid object or NULL.
        //
        // The ownership is safe as Shared; Objective-C code throwing an
        // exception knows that they don't hold sole access to that exception
        // instance any more, and Rust code is forbidden by requiring a Shared
        // Id in `throw` (instead of just a shared reference, which could have
        // come from an Owned Id).
        Err(unsafe { Id::new(exception.cast()) })
    }
}

/// Tries to execute the given closure and catches an Objective-C exception
/// if one is thrown.
///
/// This is the Objective-C equivalent of Rust's [`catch_unwind`].
/// Accordingly, if your Rust code is compiled with `panic=abort` this cannot
/// catch the exception.
///
/// Returns a `Result` that is either `Ok` if the closure succeeded without an
/// exception being thrown, or an `Err` with the exception. The exception is
/// automatically released.
///
/// The exception is `None` in the extremely exceptional case that the
/// exception object is `nil`. This should basically never happen, but is
/// technically possible on some systems with `@throw nil`.
///
/// [`catch_unwind`]: std::panic::catch_unwind
///
///
/// # Safety
///
/// The given closure must not panic (e.g. normal Rust unwinding into this
/// causes undefined behaviour).
///
/// Additionally, this unwinds through the closure from Objective-C, which is
/// undefined behaviour until `C-unwind` is stabilized, see [RFC-2945] - you
/// can try this out on nightly using the `unstable-c-unwind` feature flag.
///
/// [RFC-2945]: https://rust-lang.github.io/rfcs/2945-c-unwind-abi.html
#[cfg(feature = "exception")]
pub unsafe fn catch<R>(
    closure: impl FnOnce() -> R + UnwindSafe,
) -> Result<R, Option<Id<Exception>>> {
    let mut value = None;
    let value_ref = &mut value;
    let closure = move || {
        *value_ref = Some(closure());
    };
    let result = unsafe { try_no_ret(closure) };
    // If the try succeeded, this was set so it's safe to unwrap
    result.map(|()| value.unwrap())
}

#[cfg(test)]
#[cfg(feature = "exception")]
mod tests {
    use alloc::format;
    use alloc::string::ToString;

    use super::*;
    use crate::runtime::NSObject;
    use crate::{msg_send_id, ClassType};

    #[test]
    fn test_catch() {
        let mut s = "Hello".to_string();
        let result = unsafe {
            catch(move || {
                s.push_str(", World!");
                s
            })
        };
        assert_eq!(result.unwrap(), "Hello, World!");
    }

    #[test]
    #[cfg_attr(
        all(feature = "apple", target_os = "macos", target_arch = "x86"),
        ignore = "`NULL` exceptions are invalid on 32-bit / w. fragile runtime"
    )]
    fn test_catch_null() {
        let s = "Hello".to_string();
        let result = unsafe {
            catch(move || {
                if !s.is_empty() {
                    ffi::objc_exception_throw(ptr::null_mut())
                }
                s.len()
            })
        };
        assert!(result.unwrap_err().is_none());
    }

    #[test]
    fn test_throw_catch_object() {
        let obj: Id<Exception> = unsafe { msg_send_id![NSObject::class(), new] };
        // TODO: Investigate why this is required on GNUStep!
        let _obj2 = obj.clone();
        let ptr: *const Exception = &*obj;

        let result = unsafe { catch(|| throw(obj)) };
        let obj = result.unwrap_err().unwrap();

        assert_eq!(format!("{obj:?}"), format!("exception <NSObject: {ptr:p}>"));

        assert!(ptr::eq(&*obj, ptr));
    }
}
