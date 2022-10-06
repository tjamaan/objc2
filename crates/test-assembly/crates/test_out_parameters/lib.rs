//! Test that Id::writeback does the correct thing.
//!
//! Note that without `panic = "abort"`, this generates a lot more code to
//! ensure that if the message send panics, the `param` (whether it has been
//! overwritten yet or not) is still released.
use objc2::ffi::NSInteger;
use objc2::rc::{Id, Owned};
use objc2::runtime::{Object, Sel};
use objc2::MessageReceiver;

unsafe fn handle(obj: &Object, sel: Sel, param: &mut *mut Object) -> NSInteger {
    MessageReceiver::send_message(obj, sel, (param,))
}

type Res = (NSInteger, Option<Id<Object, Owned>>);

#[no_mangle]
unsafe fn null(obj: &Object, sel: Sel) -> Res {
    let mut param = None;
    let res = Id::writeback(&mut param, |param| handle(obj, sel, param));
    (res, param)
}

#[no_mangle]
unsafe fn nonnull(obj: &Object, sel: Sel, param: Id<Object, Owned>) -> Res {
    let mut param = Some(param);
    let res = Id::writeback(&mut param, |param| handle(obj, sel, param));
    (res, param)
}

#[no_mangle]
unsafe fn generic(obj: &Object, sel: Sel, mut param: Option<Id<Object, Owned>>) -> Res {
    let res = Id::writeback(&mut param, |param| handle(obj, sel, param));
    (res, param)
}
