use core::hash;
use core::marker::PhantomData;
use core::ptr::NonNull;

use crate::encode::{Encoding, RefEncode};
use crate::foundation::NSObject;
use crate::runtime::{Object, Protocol};
use crate::Message;

/// TODO
#[repr(C)]
pub struct ProtocolObject<P: ?Sized + ProtocolType> {
    inner: Object,
    p: PhantomData<P>,
}

unsafe impl<P: ?Sized + ProtocolType> RefEncode for ProtocolObject<P> {
    const ENCODING_REF: Encoding = Object::ENCODING_REF;
}

unsafe impl<P: ?Sized + ProtocolType> Message for ProtocolObject<P> {}

// TODO: Implement Hash, Eq, PartialEq, Debug

impl<P: ?Sized + ProtocolType> hash::Hash for ProtocolObject<P>
where
    Self: ConformsTo<NSObject>,
{
    #[inline]
    fn hash<H: hash::Hasher>(&self, _state: &mut H) {
        // self.as_protocol::<NSObject>().hash(state);
        todo!()
    }
}

impl<P, T> AsRef<ProtocolObject<P>> for ProtocolObject<T>
where
    P: ?Sized + ProtocolType,
    T: ?Sized + ProtocolType,
    Self: ConformsTo<P>,
{
    #[inline]
    fn as_ref(&self) -> &ProtocolObject<P> {
        self.as_protocol()
    }
}

impl<P, T> AsMut<ProtocolObject<P>> for ProtocolObject<T>
where
    P: ?Sized + ProtocolType,
    T: ?Sized + ProtocolType,
    Self: ConformsTo<P>,
{
    #[inline]
    fn as_mut(&mut self) -> &mut ProtocolObject<P> {
        self.as_protocol_mut()
    }
}

// TODO: Maybe iplement Borrow + BorrowMut?

/// Marks types that represent specific protocols.
///
/// This is the protocol equivalent of [`ClassType`].
///
/// This is implemented automatically by the [`extern_protocol!`] macro.
///
/// [`ClassType`]: crate::ClassType
/// [`extern_protocol!`]: crate::extern_protocol
///
///
/// # Safety
///
/// This is meant to be a sealed trait, and should not be implemented outside
/// of the [`extern_protocol!`] macro.
///
///
/// # Examples
///
/// Use the trait to access the [`Protocol`] of different objects.
///
/// ```
/// # #[cfg(feature = "gnustep-1-7")]
/// # unsafe { objc2::__gnustep_hack::get_class_to_force_linkage() };
/// use objc2::ProtocolType;
/// use objc2::foundation::NSObject;
/// // Get a protocol object representing `NSObject`
/// let protocol = NSObject::protocol();
/// ```
///
/// Use the [`extern_protocol!`] macro to implement this trait for a type.
///
/// ```no_run
/// use objc2::{extern_protocol, ProtocolType};
///
/// extern_protocol!(
///     unsafe trait MyProtocol {
///         #[method(aMethod)]
///         fn a_method(&self);
///     }
///
///     unsafe impl ProtocolType for dyn MyProtocol {}
/// );
///
/// let protocol = <dyn MyProtocol>::protocol();
/// ```
pub unsafe trait ProtocolType {
    /// The name of the Objective-C protocol that this type represents.
    const NAME: &'static str;

    /// Get a reference to the Objective-C protocol object that this type
    /// represents.
    ///
    /// May register the protocol with the runtime if it wasn't already.
    ///
    /// Note that some protocols [are not registered with the runtime][p-obj],
    /// depending on various factors. In those cases, this function may return
    /// `None`.
    ///
    /// [p-obj]: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocProtocols.html#//apple_ref/doc/uid/TP30001163-CH15-TPXREF149
    ///
    ///
    /// # Panics
    ///
    /// This may panic if something went wrong with getting or declaring the
    /// protocol, e.g. if the program is not properly linked to the framework
    /// that defines the protocol.
    fn protocol() -> Option<&'static Protocol> {
        Protocol::get(Self::NAME)
    }

    #[doc(hidden)]
    const __INNER: ();
}

/// Marks that a type conforms to a specific protocol.
///
/// This can be implemented both for types representing classes and types
/// representing protocols.
///
/// See [Apple's documentation on conforming to protocols][conform] for more
/// information.
///
/// [conform]: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithProtocols/WorkingwithProtocols.html#//apple_ref/doc/uid/TP40011210-CH11-SW3
///
///
/// # Safety
///
/// The object must actually conform to the specified protocol.
pub unsafe trait ConformsTo<P: ?Sized + ProtocolType>: Message {
    /// Get an immutable reference to a type representing the protocol.
    fn as_protocol(&self) -> &ProtocolObject<P> {
        let ptr: NonNull<Self> = NonNull::from(self);
        let ptr: NonNull<ProtocolObject<P>> = ptr.cast();
        // SAFETY: Implementer ensures that the object conforms to the
        // protocol; so converting the reference here is safe.
        unsafe { ptr.as_ref() }
    }

    /// Get a mutable reference to a type representing the protocol.
    fn as_protocol_mut(&mut self) -> &mut ProtocolObject<P> {
        let ptr: NonNull<Self> = NonNull::from(self);
        let mut ptr: NonNull<ProtocolObject<P>> = ptr.cast();
        // SAFETY: Same as `as_protocol`.
        //
        // Since the reference came from a mutable reference to start with,
        // returning a mutable reference here is safe (the lifetime of the
        // returned reference is bound to the input).
        unsafe { ptr.as_mut() }
    }
}

// SAFETY: Trivial
unsafe impl<P: ?Sized + ProtocolType> ConformsTo<P> for ProtocolObject<P> {
    fn as_protocol(&self) -> &ProtocolObject<P> {
        self
    }

    fn as_protocol_mut(&mut self) -> &mut ProtocolObject<P> {
        self
    }
}
