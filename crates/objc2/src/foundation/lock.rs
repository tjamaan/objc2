use super::{NSObject, NSString};
use crate::rc::{Id, Owned, Shared};
use crate::{extern_class, extern_methods, extern_protocol, ClassType, ConformsTo, ProtocolType};

// TODO: Proper Send/Sync impls here

extern_protocol!(
    pub unsafe trait NSLocking {
        #[method(lock)]
        unsafe fn lock(&self);

        #[method(unlock)]
        unsafe fn unlock(&self);
    }

    unsafe impl ProtocolType for dyn NSLocking {}
);

extern_class!(
    #[derive(Debug)]
    pub struct NSLock;

    unsafe impl ClassType for NSLock {
        type Super = NSObject;
    }
);

unsafe impl ConformsTo<dyn NSLocking> for NSLock {}

extern_methods!(
    unsafe impl NSLock {
        #[method_id(new)]
        pub fn new() -> Id<Self, Owned>;

        #[method(tryLock)]
        pub unsafe fn try_lock(&self) -> bool;

        #[method_id(name)]
        pub fn name(&self) -> Option<Id<NSString, Shared>>;

        #[method(setName:)]
        pub fn set_name(&mut self, name: Option<&NSString>);
    }
);

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ProtocolObject;

    #[test]
    fn lock_unlock() {
        let lock = NSLock::new();
        unsafe {
            lock.lock();
            assert!(!lock.try_lock());
            lock.unlock();
            assert!(lock.try_lock());
            lock.unlock();
        }
    }

    #[test]
    fn lock_unlock_on_protocol() {
        let obj = NSLock::new();
        let proto: &ProtocolObject<dyn NSLocking> = obj.as_protocol();
        unsafe {
            proto.lock();
            proto.unlock();
        }
    }
}
