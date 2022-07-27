//! Read from the global pasteboard, and write a new string into it.
//!
//! Works on macOS 10.7+
#![deny(unsafe_op_in_unsafe_fn)]
use std::mem::ManuallyDrop;
use std::ops::{Deref, DerefMut};

use objc2::rc::{Id, Shared};
use objc2::runtime::{Class, Object};
use objc2::{msg_send, msg_send_bool, msg_send_id};
use objc2::{Encoding, Message, RefEncode};

use objc2_foundation::{NSArray, NSDictionary, NSInteger, NSObject, NSString};

type NSPasteboardType = NSString;
type NSPasteboardReadingOptionKey = NSString;

#[cfg(all(feature = "apple", target_os = "macos"))]
#[link(name = "AppKit", kind = "framework")]
extern "C" {
    /// <https://developer.apple.com/documentation/appkit/nspasteboardtypestring?language=objc>
    static NSPasteboardTypeString: Option<&'static NSPasteboardType>;
}
#[cfg(not(all(feature = "apple", target_os = "macos")))]
#[allow(non_upper_case_globals)]
const NSPasteboardTypeString: Option<&'static NSPasteboardType> = None;

/// <https://developer.apple.com/documentation/appkit/nspasteboard?language=objc>
#[repr(C)]
pub struct NSPasteboard {
    // Required for proper layout
    inner: NSObject,
}

// SAFETY: NSPasteboard is an FFI-safe struct and is encoded as an object.
unsafe impl RefEncode for NSPasteboard {
    const ENCODING_REF: Encoding<'static> = Encoding::Object;
}

// SAFETY: NSPasteboard can safely be sent messages, and it responds to the
// normal `retain`, `release` and `autorelease` messages.
unsafe impl Message for NSPasteboard {}

impl Deref for NSPasteboard {
    type Target = NSObject;

    #[inline]
    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

impl DerefMut for NSPasteboard {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.inner
    }
}

impl NSPasteboard {
    /// Common convenience method.
    pub fn class() -> &'static Class {
        #[cfg(all(feature = "apple", target_os = "macos"))]
        {
            objc2::class!(NSPasteboard)
        }
        #[cfg(not(all(feature = "apple", target_os = "macos")))]
        {
            panic!("this example only works on macOS")
        }
    }

    /// We return a `Shared` `Id` because `general` can easily be called
    /// again, and it would return the same object, resulting in two aliasing
    /// mutable references if we returned an `Owned` Id.
    ///
    /// Besides, even if we could prevent this, there might be Objective-C
    /// code somewhere else that accesses this instance.
    ///
    /// TODO: Is this safe to call outside the main thread?
    ///
    /// <https://developer.apple.com/documentation/appkit/nspasteboard/1530091-generalpasteboard?language=objc>
    pub fn general() -> Id<Self, Shared> {
        unsafe { msg_send_id![Self::class(), generalPasteboard].unwrap() }
    }

    /// Simple, straightforward implementation
    ///
    /// <https://developer.apple.com/documentation/appkit/nspasteboard/1533566-stringfortype?language=objc>
    pub fn text_impl_1(&self) -> Id<NSString, Shared> {
        unsafe { msg_send_id![self, stringForType: NSPasteboardTypeString.unwrap()].unwrap() }
    }

    /// More complex implementation using `readObjectsForClasses:options:`,
    /// intended to show some how some patterns might require more knowledge
    /// of nitty-gritty details.
    ///
    /// <https://developer.apple.com/documentation/appkit/nspasteboard/1524454-readobjectsforclasses?language=objc>
    pub fn text_impl_2(&self) -> Id<NSString, Shared> {
        // The NSPasteboard API is a bit weird, it requires you to pass
        // classes as objects, which `objc2_foundation::NSArray` was not
        // really made for - so we convert the class to an `Object` type
        // instead. Also, we wrap it in `ManuallyDrop` because I'm not sure
        // how classes handle `release` calls?
        //
        // TODO: Investigate and find a better way to express this in objc2.
        let string_classes: ManuallyDrop<[Id<Object, Shared>; 1]> = {
            let cls: *const Class = NSString::class();
            let cls = cls as *mut Object;
            unsafe { ManuallyDrop::new([Id::new(cls).unwrap()]) }
        };
        // Temporary, see https://github.com/rust-lang/rust-clippy/issues/9101
        #[allow(unknown_lints, clippy::explicit_auto_deref)]
        let class_array = NSArray::from_slice(&*string_classes);
        let options = NSDictionary::new();
        let objects = unsafe { self.read_objects_for_classes(&class_array, &options) };

        // TODO: Should perhaps return Id<Object, Shared>?
        let ptr: *const Object = objects.first().unwrap();

        // And this part is weird as well, since we now have to convert the
        // object into an NSString, which we know it to be since that's what
        // we told `readObjectsForClasses:options:`.
        let ptr = ptr as *mut NSString;
        unsafe { Id::retain(ptr) }.unwrap()
    }

    /// Defined here to make it easier to declare which types are expected.
    /// This is a common pattern that I can wholeheartedly recommend!
    ///
    /// SAFETY: `class_array` must contain classes!
    unsafe fn read_objects_for_classes(
        &self,
        class_array: &NSArray<Object, Shared>,
        options: &NSDictionary<NSPasteboardReadingOptionKey, Object>,
    ) -> Id<NSArray<Object, Shared>, Shared> {
        unsafe { msg_send_id![self, readObjectsForClasses: class_array, options: options].unwrap() }
    }

    /// This takes `&self` even though `writeObjects:` would seem to mutate
    /// the pasteboard. "What is going on?", you might rightfully ask!
    ///
    /// We do this because we can't soundly get a mutable reference to the
    /// global `NSPasteboard` instance, see [`NSPasteboard::general`].
    ///
    /// This is sound because `NSPasteboard` contains `NSObject`, which in
    /// turn contains `UnsafeCell`, allowing interior mutability.
    ///
    /// <https://developer.apple.com/documentation/appkit/nspasteboard/1533599-clearcontents?language=objc>
    /// <https://developer.apple.com/documentation/appkit/nspasteboard/1525945-writeobjects?language=objc>
    pub fn set_text(&self, text: Id<NSString, Shared>) {
        let _: NSInteger = unsafe { msg_send![self, clearContents] };
        let string_array = NSArray::from_slice(&[text]);
        if !unsafe { msg_send_bool![self, writeObjects: &*string_array] } {
            panic!("Failed writing to pasteboard");
        }
    }
}

fn main() {
    let pasteboard = NSPasteboard::general();
    let impl_1 = pasteboard.text_impl_1();
    let impl_2 = pasteboard.text_impl_1();
    println!("Pasteboard text from implementation 1 was: {:?}", impl_1);
    println!("Pasteboard text from implementation 2 was: {:?}", impl_2);
    assert_eq!(impl_1, impl_2);

    let s = NSString::from_str("Hello, world!");
    pasteboard.set_text(s.clone());
    println!("Now the pasteboard text should be: {:?}", s);
    assert_eq!(s, pasteboard.text_impl_1());
}
