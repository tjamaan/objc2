//! Test assembly output of `declare_class!`.
#![cfg(feature = "foundation")]

use core::mem::ManuallyDrop;
use core::ptr;

use objc2::declare::IvarDrop;
use objc2::foundation::NSObject;
use objc2::rc::{Id, Shared};
use objc2::runtime::Class;
use objc2::{declare_class, msg_send_id, ClassType};

declare_class!(
    #[no_mangle]
    pub struct Custom {
        ivar1: u8,
        ivar2: IvarDrop<Option<Id<NSObject, Shared>>>,
        // ivar3: IvarDrop<Id<NSObject, Shared>>,
    }

    unsafe impl ClassType for Custom {
        type Super = NSObject;
        const NAME: &'static str = "CustomClassName";
    }

    unsafe impl Custom {
        #[no_mangle]
        #[method(classMethod)]
        fn class_method() {}

        #[no_mangle]
        #[method(instanceMethod)]
        fn instance_method(&self) {}
    }
);

#[no_mangle]
#[inline(never)]
pub fn get_class() -> &'static Class {
    Custom::class()
}

#[no_mangle]
#[inline(never)]
pub fn get_obj() -> ManuallyDrop<Id<Custom, Shared>> {
    let obj: Option<_> = unsafe { msg_send_id![get_class(), new] };
    ManuallyDrop::new(unsafe { obj.unwrap_unchecked() })
}

#[no_mangle]
#[inline(never)]
pub fn access() -> (u8, *const NSObject) {
    let obj = get_obj();
    (
        *obj.ivar1,
        (*obj.ivar2)
            .as_ref()
            .map(|obj| Id::as_ptr(&obj))
            .unwrap_or_else(ptr::null),
    )
}
