//! Bindings to the `Foundation` framework.
//!
//! This is the [`std`] equivalent for Objective-C, containing essential data
//! types, collections, and operating-system services.
//!
//! See [Apple's documentation](https://developer.apple.com/documentation/foundation?language=objc).
//!
//!
//! ## Philosophy
//!
//! The `Foundation` framework is _huge_! If we aspired to map every API it
//! exposes (a lot of it is just helper methods to make Objective-C more
//! ergonomic), this library would never be finished. Instead, our focus lies
//! on conversion methods, to allow easily using them from Rust.
//!
//! If you find some API that an object doesn't expose (but should), we gladly
//! accept [pull requests]. If it is something that is out of scope, these
//! objects implement the [`Message`] trait, so you can always just manually
//! call a method on them using the [`msg_send!`] family of macros.
//!
//! [pull requests]: https://github.com/madsmtm/objc2/pulls
//! [`Message`]: crate::objc2::Message
//! [`msg_send!`]: crate::objc2::msg_send
//!
//!
//! # Use of `Deref`
//!
//! `icrate` uses the [`Deref`] trait in a bit special way: All objects deref
//! to their superclasses. For example, `NSMutableArray` derefs to `NSArray`,
//! which in turn derefs to `NSObject`.
//!
//! Note that this is explicitly recommended against in [the
//! documentation][`Deref`] and [the Rust Design patterns
//! book][anti-pattern-deref] (see those links for details).
//!
//! Due to Objective-C objects only ever being accessible behind pointers in
//! the first place, the problems stated there are less severe, and having the
//! implementation just means that everything is much nicer when you actually
//! want to use the objects!
//!
//! All objects also implement [`AsRef`] and [`AsMut`] to their superclass,
//! and can be used in [`Id::into_super`], so if you favour explicit
//! conversion, that is a possibility too.
//!
//! [`Deref`]: std::ops::Deref
//! [`ClassType`]: crate::objc2::ClassType
//! [anti-pattern-deref]: https://rust-unofficial.github.io/patterns/anti_patterns/deref.html
//! [`Id::into_super`]: objc2::rc::Id::into_super
//!
//!
//! # Ownership
//!
//! TODO.
//!
//! While `NSArray` _itself_ is immutable, i.e. the number of objects it
//! contains can't change, it is still possible to modify the contained
//! objects themselves, if you know you're the sole owner of them -
//! quite similar to how you can modify elements in `Box<[T]>`.
//!
//! To mutate the contained objects the ownership must be `O = Owned`. A
//! summary of what the different "types" of arrays allow you to do can be
//! found below. `Array` refers to either `NSArray` or `NSMutableArray`.
//! - `Id<NSMutableArray<T, Owned>, Owned>`: Allows you to mutate the
//!   objects, and the array itself.
//! - `Id<NSMutableArray<T, Shared>, Owned>`: Allows you to mutate the
//!   array itself, but not it's contents.
//! - `Id<NSArray<T, Owned>, Owned>`: Allows you to mutate the objects,
//!   but not the array itself.
//! - `Id<NSArray<T, Shared>, Owned>`: Effectively the same as the below.
//! - `Id<Array<T, Shared>, Shared>`: Allows you to copy the array, but
//!   does not allow you to modify it in any way.
//! - `Id<Array<T, Owned>, Shared>`: Pretty useless compared to the
//!   others, avoid this.
//!
//!
//! # Rust vs. Objective-C types
//!
//! | Objective-C | (approximately) equivalent Rust |
//! | --- | --- |
//! | `NSData` | `Box<[u8]>` |
//! | `NSMutableData` | `Vec<u8>` |
//! | `NSString` | `Box<str>` |
//! | `NSMutableString` | `String` |
//! | `NSValue` | `Box<dyn Any>` |
//! | `NSNumber` | `enum { I8(i8), U8(u8), I16(i16), U16(u16), I32(i32), U32(u32), I64(i64), U64(u64), F32(f32), F64(f64), CLong(ffi::c_long), CULong(ffi::c_ulong) }` |
//! | `NSError` | `Box<dyn Error>` |
//! | `NSException` | `Box<dyn Error>` |
//! | `NSRange` | `ops::Range<usize>` |
//! | `NSComparisonResult` | `cmp::Ordering` |
//! | `NSArray<T, Shared>` | `Box<[Arc<T>]>` |
//! | `NSArray<T, Owned>` | `Box<[T]>` |
//! | `NSMutableArray<T, Shared>` | `Vec<Arc<T>>` |
//! | `NSMutableArray<T, Owned>` | `Vec<T>` |
//! | `NSDictionary<K, V>` | `ImmutableMap<Arc<K>, Arc<V>>` |
//! | `NSDictionary<K, V, Owned, Owned>` | `ImmutableMap<K, V>` |
//! | `NSMutableDictionary<K, V>` | `Map<Arc<K>, Arc<V>>` |
//! | `NSMutableDictionary<K, V, Owned, Owned>` | `Map<K, V>` |
//! | `NSEnumerator<T, Shared>` | `impl Iterator<Arc<T>>` |
//! | `NSEnumerator<T, Owned>` | `impl Iterator<T>` |
//! | `@protocol NSCopying` | `trait Clone` |
#![allow(unused_imports)]

#[doc(hidden)]
pub mod __macro_helpers;
mod additions;
mod fixes;
#[path = "../generated/Foundation/mod.rs"]
mod generated;
mod macros;

pub use self::additions::*;
pub use self::fixes::*;
pub use self::generated::*;

pub use objc2::runtime::{NSObject, NSObjectProtocol, NSZone};
// Available under Foundation, so makes sense here as well:
// https://developer.apple.com/documentation/foundation/numbers_data_and_basic_values?language=objc
pub use objc2::ffi::{NSInteger, NSUInteger};

// Link to the correct framework
#[cfg_attr(feature = "apple", link(name = "Foundation", kind = "framework"))]
#[cfg_attr(feature = "gnustep-1-7", link(name = "gnustep-base", kind = "dylib"))]
extern "C" {}
