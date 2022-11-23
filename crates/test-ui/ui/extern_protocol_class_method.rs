use objc2::{extern_protocol, ProtocolType};
// use objc2::rc::{Id, Owned};

extern_protocol!(
    pub unsafe trait MyProtocol {
        #[method(a)]
        /// Doc comment
        #[optional]
        fn a();

        #[optional]
        #[method_id(b)]
        /// Doc comment
        fn b() -> Id<Self, Owned>;

        #[method(c)]
        /// Doc comment
        fn c(arg: i32);

        #[method_id(d)]
        /// Doc comment
        fn d(arg: i32) -> Id<Self, Owned>;
    }

    unsafe impl ProtocolType for dyn MyProtocol {}
);

fn main() {}
