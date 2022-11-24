	.section	__TEXT,__text,regular,pure_instructions
	.intel_syntax noprefix
	.p2align	4, 0x90
SYM(core[CRATE_ID]::class_type::ClassType>::class::{closure#0}>::{closure#0}>, 0):
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::fmt::Error>, 0):
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::string::String>, 0):
	push	rbp
	mov	rbp, rsp
	mov	rsi, qword ptr [rdi + 8]
	test	rsi, rsi
	je	LBB2_1
	mov	rdi, qword ptr [rdi]
	mov	edx, 1
	pop	rbp
	jmp	___rust_dealloc
LBB2_1:
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::ffi::c_str::NulError>, 0):
	push	rbp
	mov	rbp, rsp
	mov	rsi, qword ptr [rdi + 16]
	test	rsi, rsi
	je	LBB3_1
	mov	rdi, qword ptr [rdi + 8]
	mov	edx, 1
	pop	rbp
	jmp	___rust_dealloc
LBB3_1:
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::string::String>, 1):
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::ptr::drop_in_place::<&usize>, 0):
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core[CRATE_ID]::panicking::assert_failed::<usize, usize>, 0):
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	qword ptr [rbp - 8], rdi
	mov	qword ptr [rbp - 16], rsi
	mov	rax, qword ptr [rdx + 40]
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rdx + 32]
	mov	qword ptr [rbp - 32], rax
	mov	rax, qword ptr [rdx + 24]
	mov	qword ptr [rbp - 40], rax
	mov	rax, qword ptr [rdx + 16]
	mov	qword ptr [rbp - 48], rax
	mov	rax, qword ptr [rdx]
	mov	rdx, qword ptr [rdx + 8]
	mov	qword ptr [rbp - 56], rdx
	mov	qword ptr [rbp - 64], rax
	mov	qword ptr [rsp], rcx
	lea	rdx, [rip + l_anon.[ID].25]
	lea	rsi, [rbp - 8]
	lea	rcx, [rbp - 16]
	lea	r9, [rbp - 64]
	xor	edi, edi
	mov	r8, rdx
	call	SYM(core::panicking::assert_failed_inner::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(alloc[CRATE_ID]::alloc::Global>, 0):
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	mov	r14, rsi
	mov	rbx, rdi
	test	rdx, rdx
	je	LBB7_5
	cmp	qword ptr [rcx + 16], 0
	je	LBB7_3
	mov	rsi, qword ptr [rcx + 8]
	test	rsi, rsi
	je	LBB7_3
	mov	rdi, qword ptr [rcx]
	mov	edx, 1
	mov	rcx, r14
	call	___rust_realloc
	test	rax, rax
	jne	LBB7_11
	jmp	LBB7_12
LBB7_3:
	test	r14, r14
	je	LBB7_4
	mov	esi, 1
	mov	rdi, r14
	call	___rust_alloc
	test	rax, rax
	jne	LBB7_11
LBB7_12:
	mov	qword ptr [rbx + 8], r14
	mov	qword ptr [rbx + 16], 1
	jmp	LBB7_6
LBB7_5:
	mov	qword ptr [rbx + 8], r14
	mov	qword ptr [rbx + 16], 0
LBB7_6:
	mov	eax, 1
	jmp	LBB7_7
LBB7_4:
	mov	eax, 1
	xor	r14d, r14d
LBB7_11:
	mov	qword ptr [rbx + 8], rax
	mov	qword ptr [rbx + 16], r14
	xor	eax, eax
LBB7_7:
	mov	qword ptr [rbx], rax
	pop	rbx
	pop	r14
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(<alloc[CRATE_ID]::alloc::Global>, 0):
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	sub	rsp, 48
	add	rsi, rdx
	jb	LBB8_10
	mov	r14, rdi
	mov	rax, qword ptr [rdi + 8]
	lea	rcx, [rax + rax]
	cmp	rcx, rsi
	cmova	rsi, rcx
	cmp	rsi, 9
	mov	ebx, 8
	cmovae	rbx, rsi
	mov	rdx, rbx
	not	rdx
	shr	rdx, 63
	test	rax, rax
	je	LBB8_3
	mov	rcx, qword ptr [r14]
	mov	qword ptr [rbp - 40], rcx
	mov	qword ptr [rbp - 32], rax
	mov	qword ptr [rbp - 24], 1
	jmp	LBB8_4
LBB8_3:
	mov	qword ptr [rbp - 24], 0
LBB8_4:
	lea	rdi, [rbp - 64]
	lea	rcx, [rbp - 40]
	mov	rsi, rbx
	call	SYM(alloc[CRATE_ID]::alloc::Global>, 0)
	cmp	qword ptr [rbp - 64], 0
	mov	rdi, qword ptr [rbp - 56]
	je	LBB8_5
	mov	rsi, qword ptr [rbp - 48]
	movabs	rax, -9223372036854775807
	cmp	rsi, rax
	je	LBB8_6
	test	rsi, rsi
	jne	LBB8_9
LBB8_10:
	call	SYM(alloc::raw_vec::capacity_overflow::GENERATED_ID, 0)
LBB8_5:
	mov	qword ptr [r14], rdi
	mov	qword ptr [r14 + 8], rbx
LBB8_6:
	add	rsp, 48
	pop	rbx
	pop	r14
	pop	rbp
	ret
LBB8_9:
	call	SYM(alloc::alloc::handle_alloc_error::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<std[CRATE_ID]::class_type::ClassType>::class::{closure#0}>::{closure#0}, 0):
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 184
	mov	rax, qword ptr [rdi]
	test	byte ptr [rax], 1
	mov	byte ptr [rax], 0
	je	LBB9_70
	mov	rbx, qword ptr [rip + SYM(<objc2::foundation::object::NSObject as objc2::class_type::ClassType>::class::CACHED_CLASS::GENERATED_ID, 0)@GOTPCREL]
	mov	rdx, qword ptr [rbx]
	test	rdx, rdx
	jne	LBB9_3
	lea	rdi, [rip + l_anon.[ID].41]
	call	_objc_getClass
	mov	rdx, rax
	mov	qword ptr [rbx], rax
LBB9_3:
	test	rdx, rdx
	je	LBB9_71
	lea	rdi, [rip + l_anon.[ID].52]
	mov	esi, 15
	call	SYM(objc2::declare::ClassBuilder::new::GENERATED_ID, 0)
	test	rax, rax
	je	LBB9_72
	mov	qword ptr [rbp - 168], rax
	lea	rsi, [rip + l_anon.[ID].16]
	mov	qword ptr [rbp - 208], rsi
	mov	qword ptr [rbp - 200], 5
	lea	rdi, [rbp - 152]
	mov	edx, 5
	call	SYM(<&str as alloc::ffi::c_str::CString::new::SpecNewImpl>::spec_new_impl::GENERATED_ID, 0)
	cmp	qword ptr [rbp - 144], 0
	jne	LBB9_6
	mov	r12, qword ptr [rbp - 136]
	mov	r14, qword ptr [rbp - 128]
	mov	qword ptr [rbp - 192], 1
	mov	qword ptr [rbp - 184], 0
	mov	qword ptr [rbp - 176], 0
	lea	rdx, [rip + l_anon.[ID].32]
	lea	rbx, [rbp - 104]
	lea	rsi, [rbp - 192]
	mov	rdi, rbx
	call	SYM(core::fmt::Formatter::new::GENERATED_ID, 0)
	lea	rdi, [rip + l_anon.[ID].17]
	mov	rsi, rbx
	call	SYM(<objc2_encode::encoding::Encoding as core::fmt::Display>::fmt::GENERATED_ID, 0)
	test	al, al
	jne	LBB9_73
	mov	rax, qword ptr [rbp - 176]
	mov	qword ptr [rbp - 88], rax
	mov	rax, qword ptr [rbp - 192]
	mov	rcx, qword ptr [rbp - 184]
	mov	qword ptr [rbp - 96], rcx
	mov	qword ptr [rbp - 104], rax
	lea	r15, [rbp - 152]
	lea	rsi, [rbp - 104]
	mov	rdi, r15
	call	SYM(alloc::string::<impl core::convert::From<alloc::string::String> for alloc::vec::Vec<u8>>::from::GENERATED_ID, 0)
	mov	r13, qword ptr [rbp - 152]
	mov	rbx, qword ptr [rbp - 136]
	cmp	rbx, 16
	jae	LBB9_9
	test	rbx, rbx
	je	LBB9_11
	xor	eax, eax
	xor	edx, edx
	.p2align	4, 0x90
LBB9_13:
	cmp	byte ptr [r13 + rdx], 0
	je	LBB9_14
	inc	rdx
	cmp	rbx, rdx
	jne	LBB9_13
	mov	rdx, rbx
	test	rax, rax
	je	LBB9_21
	jmp	LBB9_18
LBB9_9:
	xor	edi, edi
	mov	rsi, r13
	mov	rdx, rbx
	call	SYM(core::slice::memchr::memchr_aligned::GENERATED_ID, 0)
	test	rax, rax
	je	LBB9_21
	jmp	LBB9_18
LBB9_11:
	xor	edx, edx
	xor	eax, eax
	test	rax, rax
	jne	LBB9_18
LBB9_21:
	mov	rax, qword ptr [rbp - 136]
	mov	qword ptr [rbp - 88], rax
	mov	rax, qword ptr [rbp - 152]
	mov	rcx, qword ptr [rbp - 144]
	mov	qword ptr [rbp - 96], rcx
	mov	qword ptr [rbp - 104], rax
	lea	rdi, [rbp - 104]
	call	SYM(alloc::ffi::c_str::CString::_from_vec_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	r13, rdx
	lea	rdi, [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::as_mut_ptr::GENERATED_ID, 0)
	mov	edx, 1
	mov	rdi, rax
	mov	rsi, r12
	xor	ecx, ecx
	mov	r8, rbx
	call	_class_addIvar
	test	al, al
	je	LBB9_30
	mov	byte ptr [rbx], 0
	test	r13, r13
	je	LBB9_24
	mov	edx, 1
	mov	rdi, rbx
	mov	rsi, r13
	call	___rust_dealloc
LBB9_24:
	mov	byte ptr [r12], 0
	test	r14, r14
	je	LBB9_26
	mov	edx, 1
	mov	rdi, r12
	mov	rsi, r14
	call	___rust_dealloc
LBB9_26:
	lea	rsi, [rip + l_anon.[ID].18]
	mov	qword ptr [rbp - 208], rsi
	mov	qword ptr [rbp - 200], 5
	lea	rdi, [rbp - 152]
	mov	edx, 5
	call	SYM(<&str as alloc::ffi::c_str::CString::new::SpecNewImpl>::spec_new_impl::GENERATED_ID, 0)
	cmp	qword ptr [rbp - 144], 0
	jne	LBB9_6
	mov	r14, qword ptr [rbp - 136]
	mov	r13, qword ptr [rbp - 128]
	mov	qword ptr [rbp - 192], 1
	mov	qword ptr [rbp - 184], 0
	mov	qword ptr [rbp - 176], 0
	lea	rdx, [rip + l_anon.[ID].32]
	lea	rbx, [rbp - 104]
	lea	rsi, [rbp - 192]
	mov	rdi, rbx
	call	SYM(core::fmt::Formatter::new::GENERATED_ID, 0)
	lea	rdi, [rip + l_anon.[ID].19]
	mov	rsi, rbx
	call	SYM(<objc2_encode::encoding::Encoding as core::fmt::Display>::fmt::GENERATED_ID, 0)
	test	al, al
	jne	LBB9_73
	mov	rax, qword ptr [rbp - 176]
	mov	qword ptr [rbp - 88], rax
	mov	rax, qword ptr [rbp - 192]
	mov	rcx, qword ptr [rbp - 184]
	mov	qword ptr [rbp - 96], rcx
	mov	qword ptr [rbp - 104], rax
	lea	rdi, [rbp - 152]
	lea	rsi, [rbp - 104]
	call	SYM(alloc::string::<impl core::convert::From<alloc::string::String> for alloc::vec::Vec<u8>>::from::GENERATED_ID, 0)
	mov	r12, qword ptr [rbp - 152]
	mov	rbx, qword ptr [rbp - 136]
	cmp	rbx, 16
	jae	LBB9_29
	test	rbx, rbx
	je	LBB9_33
	xor	eax, eax
	xor	edx, edx
	.p2align	4, 0x90
LBB9_35:
	cmp	byte ptr [r12 + rdx], 0
	je	LBB9_36
	inc	rdx
	cmp	rbx, rdx
	jne	LBB9_35
	mov	rdx, rbx
	test	rax, rax
	je	LBB9_41
	jmp	LBB9_40
LBB9_29:
	xor	edi, edi
	mov	rsi, r12
	mov	rdx, rbx
	call	SYM(core::slice::memchr::memchr_aligned::GENERATED_ID, 0)
	test	rax, rax
	je	LBB9_41
	jmp	LBB9_40
LBB9_33:
	xor	edx, edx
	xor	eax, eax
	test	rax, rax
	jne	LBB9_40
LBB9_41:
	mov	rax, qword ptr [rbp - 136]
	mov	qword ptr [rbp - 88], rax
	mov	rax, qword ptr [rbp - 152]
	mov	rcx, qword ptr [rbp - 144]
	mov	qword ptr [rbp - 96], rcx
	mov	qword ptr [rbp - 104], rax
	lea	r12, [rbp - 104]
	mov	rdi, r12
	call	SYM(alloc::ffi::c_str::CString::_from_vec_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	r15, rdx
	lea	rdi, [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::as_mut_ptr::GENERATED_ID, 0)
	mov	edx, 8
	mov	rdi, rax
	mov	rsi, r14
	mov	ecx, 3
	mov	r8, rbx
	call	_class_addIvar
	test	al, al
	je	LBB9_74
	mov	byte ptr [rbx], 0
	test	r15, r15
	je	LBB9_44
	mov	edx, 1
	mov	rdi, rbx
	mov	rsi, r15
	call	___rust_dealloc
LBB9_44:
	mov	byte ptr [r14], 0
	test	r13, r13
	je	LBB9_46
	mov	edx, 1
	mov	rdi, r14
	mov	rsi, r13
	call	___rust_dealloc
LBB9_46:
	mov	rbx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 0).0]
	test	rbx, rbx
	jne	LBB9_48
	lea	rdi, [rip + L_anon.[ID].53]
	call	SYM(objc2::runtime::Sel::register_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 0).0], rax
LBB9_48:
	mov	qword ptr [rbp - 160], rbx
	mov	rdi, rbx
	call	SYM(objc2::declare::count_args::GENERATED_ID, 0)
	mov	qword ptr [rbp - 216], rax
	mov	qword ptr [rbp - 208], 0
	test	rax, rax
	jne	LBB9_65
	lea	rdi, [rip + l_anon.[ID].7]
	lea	rsi, [rip + l_anon.[ID].0]
	xor	edx, edx
	call	SYM(objc2::declare::method_type_encoding::GENERATED_ID, 0)
	mov	r14, rax
	mov	r15, rdx
	lea	rdi, [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::as_mut_ptr::GENERATED_ID, 0)
	lea	rdx, [rip + SYM(<test_declare_class[CRATE_ID]::Custom>::__objc2_dealloc, 0)]
	mov	rdi, rax
	mov	rsi, rbx
	mov	rcx, r14
	call	_class_addMethod
	test	al, al
	je	LBB9_69
	mov	byte ptr [r14], 0
	test	r15, r15
	je	LBB9_52
	mov	edx, 1
	mov	rdi, r14
	mov	rsi, r15
	call	___rust_dealloc
LBB9_52:
	mov	rbx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 1).0]
	test	rbx, rbx
	jne	LBB9_54
	lea	rdi, [rip + l_anon.[ID].54]
	call	SYM(objc2::runtime::Sel::register_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 1).0], rax
LBB9_54:
	mov	qword ptr [rbp - 160], rbx
	mov	rdi, rbx
	call	SYM(objc2::declare::count_args::GENERATED_ID, 0)
	mov	qword ptr [rbp - 216], rax
	mov	qword ptr [rbp - 208], 0
	test	rax, rax
	jne	LBB9_67
	lea	rdi, [rip + l_anon.[ID].7]
	lea	rsi, [rip + l_anon.[ID].0]
	xor	edx, edx
	call	SYM(objc2::declare::method_type_encoding::GENERATED_ID, 0)
	mov	r14, rax
	mov	r15, rdx
	lea	rdi, [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::metaclass_mut::GENERATED_ID, 0)
	lea	rdx, [rip + _class_method]
	mov	rdi, rax
	mov	rsi, rbx
	mov	rcx, r14
	call	_class_addMethod
	test	al, al
	je	LBB9_68
	mov	byte ptr [r14], 0
	test	r15, r15
	je	LBB9_58
	mov	edx, 1
	mov	rdi, r14
	mov	rsi, r15
	call	___rust_dealloc
LBB9_58:
	mov	rbx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 2).0]
	test	rbx, rbx
	jne	LBB9_60
	lea	rdi, [rip + l_anon.[ID].55]
	call	SYM(objc2::runtime::Sel::register_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 2).0], rax
LBB9_60:
	mov	qword ptr [rbp - 160], rbx
	mov	rdi, rbx
	call	SYM(objc2::declare::count_args::GENERATED_ID, 0)
	mov	qword ptr [rbp - 216], rax
	mov	qword ptr [rbp - 208], 0
	test	rax, rax
	jne	LBB9_65
	lea	rdi, [rip + l_anon.[ID].7]
	lea	rsi, [rip + l_anon.[ID].0]
	xor	edx, edx
	call	SYM(objc2::declare::method_type_encoding::GENERATED_ID, 0)
	mov	r14, rax
	mov	r15, rdx
	lea	rdi, [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::as_mut_ptr::GENERATED_ID, 0)
	lea	rdx, [rip + _instance_method]
	mov	rdi, rax
	mov	rsi, rbx
	mov	rcx, r14
	call	_class_addMethod
	test	al, al
	je	LBB9_69
	mov	byte ptr [r14], 0
	test	r15, r15
	je	LBB9_64
	mov	edx, 1
	mov	rdi, r14
	mov	rsi, r15
	call	___rust_dealloc
LBB9_64:
	mov	rdi, qword ptr [rbp - 168]
	call	SYM(objc2::declare::ClassBuilder::register::GENERATED_ID, 0)
	mov	rbx, rax
	lea	rsi, [rip + l_anon.[ID].16]
	lea	rcx, [rip + l_anon.[ID].17]
	mov	edx, 5
	mov	rdi, rax
	call	SYM(objc2::runtime::ivar_offset::GENERATED_ID, 0)
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::ivar1>::__offset_ptr::OFFSET, 0)], rax
	lea	rsi, [rip + l_anon.[ID].18]
	lea	rcx, [rip + l_anon.[ID].19]
	mov	edx, 5
	mov	rdi, rbx
	call	SYM(objc2::runtime::ivar_offset::GENERATED_ID, 0)
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::ivar2>::__offset_ptr::OFFSET, 0)], rax
	add	rsp, 184
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
LBB9_14:
	mov	eax, 1
	test	rax, rax
	je	LBB9_21
LBB9_18:
	mov	rax, qword ptr [rbp - 144]
	mov	qword ptr [rbp - 104], rdx
	mov	qword ptr [rbp - 96], r13
	jmp	LBB9_19
LBB9_36:
	mov	eax, 1
	test	rax, rax
	je	LBB9_41
LBB9_40:
	mov	rax, qword ptr [rbp - 144]
	mov	qword ptr [rbp - 104], rdx
	mov	qword ptr [rbp - 96], r12
LBB9_19:
	mov	qword ptr [rbp - 88], rax
	mov	qword ptr [rbp - 80], rbx
	lea	rdi, [rip + l_anon.[ID].29]
	lea	rcx, [rip + l_anon.[ID].30]
	lea	r8, [rip + l_anon.[ID].12]
	jmp	LBB9_20
LBB9_6:
	mov	rax, qword ptr [rbp - 128]
	mov	qword ptr [rbp - 80], rax
	mov	rax, qword ptr [rbp - 136]
	mov	qword ptr [rbp - 88], rax
	mov	rax, qword ptr [rbp - 152]
	mov	rcx, qword ptr [rbp - 144]
	mov	qword ptr [rbp - 96], rcx
	mov	qword ptr [rbp - 104], rax
	lea	rdi, [rip + l_anon.[ID].29]
	lea	rcx, [rip + l_anon.[ID].30]
	lea	r8, [rip + l_anon.[ID].11]
LBB9_20:
	lea	rdx, [rbp - 104]
	mov	esi, 43
	call	SYM(core::result::unwrap_failed::GENERATED_ID, 0)
LBB9_73:
	lea	rdi, [rip + l_anon.[ID].33]
	lea	rcx, [rip + l_anon.[ID].31]
	lea	r8, [rip + l_anon.[ID].35]
	lea	rdx, [rbp - 152]
	mov	esi, 55
	call	SYM(core::result::unwrap_failed::GENERATED_ID, 0)
LBB9_65:
	mov	qword ptr [rbp - 192], 0
	lea	rax, [rbp - 160]
	mov	qword ptr [rbp - 104], rax
	mov	rax, qword ptr [rip + SYM(<objc2::runtime::Sel as core::fmt::Debug>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 96], rax
	lea	rdi, [rbp - 216]
	mov	qword ptr [rbp - 88], rdi
	mov	rax, qword ptr [rip + SYM(core::fmt::num::imp::<impl core::fmt::Display for usize>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 80], rax
	lea	rcx, [rbp - 192]
	mov	qword ptr [rbp - 72], rcx
	mov	qword ptr [rbp - 64], rax
	lea	rax, [rip + l_anon.[ID].4]
	mov	qword ptr [rbp - 152], rax
	mov	qword ptr [rbp - 144], 3
	mov	qword ptr [rbp - 136], 0
	mov	qword ptr [rbp - 120], r12
	mov	qword ptr [rbp - 112], 3
	lea	rcx, [rip + l_anon.[ID].6]
	jmp	LBB9_66
LBB9_69:
	lea	rax, [rbp - 160]
	mov	qword ptr [rbp - 152], rax
	mov	rax, qword ptr [rip + SYM(<objc2::runtime::Sel as core::fmt::Debug>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].9]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 1
	mov	qword ptr [rbp - 88], 0
	lea	rax, [rbp - 152]
	mov	qword ptr [rbp - 72], rax
	mov	qword ptr [rbp - 64], 1
	lea	rsi, [rip + l_anon.[ID].10]
	lea	rdi, [rbp - 104]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)
LBB9_70:
	lea	rdi, [rip + l_anon.[ID].26]
	lea	rdx, [rip + l_anon.[ID].28]
	mov	esi, 43
	call	SYM(core::panicking::panic::GENERATED_ID, 0)
LBB9_71:
	lea	rax, [rip + l_anon.[ID].46]
	mov	qword ptr [rbp - 152], rax
	lea	rax, [rip + SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0)]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].44]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 2
	mov	qword ptr [rbp - 88], 0
	lea	rax, [rbp - 152]
	mov	qword ptr [rbp - 72], rax
	mov	qword ptr [rbp - 64], 1
	lea	rsi, [rip + l_anon.[ID].48]
	lea	rdi, [rbp - 104]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)
LBB9_72:
	lea	rax, [rip + l_anon.[ID].59]
	mov	qword ptr [rbp - 152], rax
	lea	rax, [rip + SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0)]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].58]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 2
	mov	qword ptr [rbp - 88], 0
	lea	rax, [rbp - 152]
	mov	qword ptr [rbp - 72], rax
	mov	qword ptr [rbp - 64], 1
	lea	rsi, [rip + l_anon.[ID].51]
	lea	rdi, [rbp - 104]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)
LBB9_30:
	lea	rax, [rbp - 208]
	mov	qword ptr [rbp - 152], rax
	lea	rax, [rip + SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0)]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].14]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 1
	mov	qword ptr [rbp - 88], 0
	mov	qword ptr [rbp - 72], r15
	jmp	LBB9_31
LBB9_74:
	lea	rax, [rbp - 208]
	mov	qword ptr [rbp - 152], rax
	lea	rax, [rip + SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0)]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].14]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 1
	mov	qword ptr [rbp - 88], 0
	lea	rax, [rbp - 152]
	mov	qword ptr [rbp - 72], rax
LBB9_31:
	mov	qword ptr [rbp - 64], 1
	lea	rsi, [rip + l_anon.[ID].15]
	lea	rdi, [rbp - 104]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)
LBB9_67:
	mov	qword ptr [rbp - 192], 0
	lea	rax, [rbp - 160]
	mov	qword ptr [rbp - 104], rax
	mov	rax, qword ptr [rip + SYM(<objc2::runtime::Sel as core::fmt::Debug>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 96], rax
	lea	rdi, [rbp - 216]
	mov	qword ptr [rbp - 88], rdi
	mov	rax, qword ptr [rip + SYM(core::fmt::num::imp::<impl core::fmt::Display for usize>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 80], rax
	lea	rcx, [rbp - 192]
	mov	qword ptr [rbp - 72], rcx
	mov	qword ptr [rbp - 64], rax
	lea	rax, [rip + l_anon.[ID].4]
	mov	qword ptr [rbp - 152], rax
	mov	qword ptr [rbp - 144], 3
	mov	qword ptr [rbp - 136], 0
	mov	qword ptr [rbp - 120], r12
	mov	qword ptr [rbp - 112], 3
	lea	rcx, [rip + l_anon.[ID].20]
LBB9_66:
	lea	rsi, [rbp - 208]
	lea	rdx, [rbp - 152]
	call	SYM(core[CRATE_ID]::panicking::assert_failed::<usize, usize>, 0)
LBB9_68:
	lea	rax, [rbp - 160]
	mov	qword ptr [rbp - 152], rax
	mov	rax, qword ptr [rip + SYM(<objc2::runtime::Sel as core::fmt::Debug>::fmt::GENERATED_ID, 0)@GOTPCREL]
	mov	qword ptr [rbp - 144], rax
	lea	rax, [rip + l_anon.[ID].22]
	mov	qword ptr [rbp - 104], rax
	mov	qword ptr [rbp - 96], 1
	mov	qword ptr [rbp - 88], 0
	lea	rax, [rbp - 152]
	mov	qword ptr [rbp - 72], rax
	mov	qword ptr [rbp - 64], 1
	lea	rsi, [rip + l_anon.[ID].23]
	lea	rdi, [rbp - 104]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<<std[CRATE_ID]::sync::once::OnceState,)>>::call_once::{shim:vtable#0}, 0):
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, qword ptr [rdi]
	mov	qword ptr [rbp - 8], rax
	lea	rdi, [rbp - 8]
	call	SYM(<std[CRATE_ID]::class_type::ClassType>::class::{closure#0}>::{closure#0}, 0)
	add	rsp, 16
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(<alloc[CRATE_ID]::raw_vec::RawVec<u8>>::reserve_for_push, 0):
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	sub	rsp, 48
	inc	rsi
	je	LBB11_10
	mov	r14, rdi
	mov	rax, qword ptr [rdi + 8]
	lea	rcx, [rax + rax]
	cmp	rcx, rsi
	cmova	rsi, rcx
	cmp	rsi, 9
	mov	ebx, 8
	cmovae	rbx, rsi
	mov	rdx, rbx
	not	rdx
	shr	rdx, 63
	test	rax, rax
	je	LBB11_3
	mov	rcx, qword ptr [r14]
	mov	qword ptr [rbp - 40], rcx
	mov	qword ptr [rbp - 32], rax
	mov	qword ptr [rbp - 24], 1
	jmp	LBB11_4
LBB11_3:
	mov	qword ptr [rbp - 24], 0
LBB11_4:
	lea	rdi, [rbp - 64]
	lea	rcx, [rbp - 40]
	mov	rsi, rbx
	call	SYM(alloc[CRATE_ID]::alloc::Global>, 0)
	cmp	qword ptr [rbp - 64], 0
	mov	rdi, qword ptr [rbp - 56]
	je	LBB11_5
	mov	rsi, qword ptr [rbp - 48]
	movabs	rax, -9223372036854775807
	cmp	rsi, rax
	je	LBB11_6
	test	rsi, rsi
	jne	LBB11_9
LBB11_10:
	call	SYM(alloc::raw_vec::capacity_overflow::GENERATED_ID, 0)
LBB11_5:
	mov	qword ptr [r14], rdi
	mov	qword ptr [r14 + 8], rbx
LBB11_6:
	add	rsp, 48
	pop	rbx
	pop	r14
	pop	rbp
	ret
LBB11_9:
	call	SYM(alloc::alloc::handle_alloc_error::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_char, 0):
	push	rbp
	mov	rbp, rsp
	mov	rdi, qword ptr [rdi]
	call	SYM(<alloc::string::String as core::fmt::Write>::write_char::GENERATED_ID, 0)
	xor	eax, eax
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_fmt, 0):
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	rax, qword ptr [rdi]
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rsi + 40]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rsi + 32]
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rsi + 24]
	mov	qword ptr [rbp - 32], rax
	mov	rax, qword ptr [rsi + 16]
	mov	qword ptr [rbp - 40], rax
	mov	rax, qword ptr [rsi]
	mov	rcx, qword ptr [rsi + 8]
	mov	qword ptr [rbp - 48], rcx
	mov	qword ptr [rbp - 56], rax
	lea	rsi, [rip + l_anon.[ID].36]
	lea	rdi, [rbp - 8]
	lea	rdx, [rbp - 56]
	call	SYM(core::fmt::write::GENERATED_ID, 0)
	add	rsp, 64
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_str, 0):
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r12
	push	rbx
	mov	r14, rdx
	mov	r15, rsi
	mov	r12, qword ptr [rdi]
	mov	rax, qword ptr [r12 + 8]
	mov	rbx, qword ptr [r12 + 16]
	sub	rax, rbx
	cmp	rax, rdx
	jb	LBB14_1
LBB14_2:
	mov	rdi, qword ptr [r12]
	add	rdi, rbx
	mov	rsi, r15
	mov	rdx, r14
	call	_memcpy
	add	rbx, r14
	mov	qword ptr [r12 + 16], rbx
	xor	eax, eax
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	pop	rbp
	ret
LBB14_1:
	mov	rdi, r12
	mov	rsi, rbx
	mov	rdx, r14
	call	SYM(<alloc[CRATE_ID]::alloc::Global>, 0)
	mov	rbx, qword ptr [r12 + 16]
	jmp	LBB14_2

	.p2align	4, 0x90
SYM(<&usize as core[CRATE_ID]::fmt::Debug>::fmt, 0):
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	mov	rbx, rsi
	mov	r14, qword ptr [rdi]
	mov	rdi, rsi
	call	SYM(core::fmt::Formatter::debug_lower_hex::GENERATED_ID, 0)
	test	al, al
	je	LBB15_1
	mov	rdi, r14
	mov	rsi, rbx
	pop	rbx
	pop	r14
	pop	rbp
	jmp	SYM(core::fmt::num::<impl core::fmt::LowerHex for usize>::fmt::GENERATED_ID, 0)
LBB15_1:
	mov	rdi, rbx
	call	SYM(core::fmt::Formatter::debug_upper_hex::GENERATED_ID, 0)
	mov	rdi, r14
	mov	rsi, rbx
	test	al, al
	je	LBB15_4
	pop	rbx
	pop	r14
	pop	rbp
	jmp	SYM(core::fmt::num::<impl core::fmt::UpperHex for usize>::fmt::GENERATED_ID, 0)
LBB15_4:
	pop	rbx
	pop	r14
	pop	rbp
	jmp	SYM(core::fmt::num::imp::<impl core::fmt::Display for usize>::fmt::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0):
	push	rbp
	mov	rbp, rsp
	mov	rdx, rsi
	mov	rax, qword ptr [rdi]
	mov	rsi, qword ptr [rdi + 8]
	mov	rdi, rax
	pop	rbp
	jmp	SYM(<str as core::fmt::Display>::fmt::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<alloc[CRATE_ID]::fmt::Write>::write_fmt, 0):
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	qword ptr [rbp - 8], rdi
	mov	rax, qword ptr [rsi + 40]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rsi + 32]
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rsi + 24]
	mov	qword ptr [rbp - 32], rax
	mov	rax, qword ptr [rsi + 16]
	mov	qword ptr [rbp - 40], rax
	mov	rax, qword ptr [rsi]
	mov	rcx, qword ptr [rsi + 8]
	mov	qword ptr [rbp - 48], rcx
	mov	qword ptr [rbp - 56], rax
	lea	rsi, [rip + l_anon.[ID].36]
	lea	rdi, [rbp - 8]
	lea	rdx, [rbp - 56]
	call	SYM(core::fmt::write::GENERATED_ID, 0)
	add	rsp, 64
	pop	rbp
	ret

	.p2align	4, 0x90
SYM(core::fmt::Arguments::new_v1::GENERATED_ID, 0):
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	cmp	rdx, r8
	jb	LBB18_3
	lea	rax, [r8 + 1]
	cmp	rax, rdx
	jb	LBB18_3
	mov	qword ptr [rdi], rsi
	mov	qword ptr [rdi + 8], rdx
	mov	qword ptr [rdi + 16], 0
	mov	qword ptr [rdi + 32], rcx
	mov	qword ptr [rdi + 40], r8
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
LBB18_3:
	lea	rsi, [rip + l_anon.[ID].38]
	lea	rcx, [rip + l_anon.[ID].0]
	lea	rbx, [rbp - 56]
	mov	edx, 1
	mov	rdi, rbx
	xor	r8d, r8d
	call	SYM(core::fmt::Arguments::new_v1::GENERATED_ID, 0)
	lea	rsi, [rip + l_anon.[ID].40]
	mov	rdi, rbx
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<alloc::string::String as core::fmt::Write>::write_char::GENERATED_ID, 0):
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	rbx
	push	rax
	mov	ebx, esi
	mov	r14, rdi
	cmp	esi, 128
	jae	LBB19_1
	mov	rsi, qword ptr [r14 + 16]
	cmp	rsi, qword ptr [r14 + 8]
	jne	LBB19_6
	mov	rdi, r14
	call	SYM(<alloc[CRATE_ID]::raw_vec::RawVec<u8>>::reserve_for_push, 0)
	mov	rsi, qword ptr [r14 + 16]
LBB19_6:
	mov	rax, qword ptr [r14]
	mov	byte ptr [rax + rsi], bl
	inc	rsi
	mov	qword ptr [r14 + 16], rsi
	jmp	LBB19_12
LBB19_1:
	mov	dword ptr [rbp - 28], 0
	mov	eax, ebx
	cmp	ebx, 2048
	jae	LBB19_2
	shr	eax, 6
	or	al, -64
	mov	byte ptr [rbp - 28], al
	and	bl, 63
	or	bl, -128
	mov	byte ptr [rbp - 27], bl
	mov	r15d, 2
	jmp	LBB19_9
LBB19_2:
	cmp	ebx, 65536
	jae	LBB19_3
	shr	eax, 12
	or	al, -32
	mov	byte ptr [rbp - 28], al
	mov	eax, ebx
	shr	eax, 6
	and	al, 63
	or	al, -128
	mov	byte ptr [rbp - 27], al
	and	bl, 63
	or	bl, -128
	mov	byte ptr [rbp - 26], bl
	mov	r15d, 3
	jmp	LBB19_9
LBB19_3:
	shr	eax, 18
	and	al, 7
	or	al, -16
	mov	byte ptr [rbp - 28], al
	mov	eax, ebx
	shr	eax, 12
	and	al, 63
	or	al, -128
	mov	byte ptr [rbp - 27], al
	mov	eax, ebx
	shr	eax, 6
	and	al, 63
	or	al, -128
	mov	byte ptr [rbp - 26], al
	and	bl, 63
	or	bl, -128
	mov	byte ptr [rbp - 25], bl
	mov	r15d, 4
LBB19_9:
	mov	rax, qword ptr [r14 + 8]
	mov	rbx, qword ptr [r14 + 16]
	sub	rax, rbx
	cmp	rax, r15
	jb	LBB19_10
LBB19_11:
	mov	rdi, qword ptr [r14]
	add	rdi, rbx
	lea	rsi, [rbp - 28]
	mov	rdx, r15
	call	_memcpy
	add	rbx, r15
	mov	qword ptr [r14 + 16], rbx
LBB19_12:
	xor	eax, eax
	add	rsp, 8
	pop	rbx
	pop	r14
	pop	r15
	pop	rbp
	ret
LBB19_10:
	mov	rdi, r14
	mov	rsi, rbx
	mov	rdx, r15
	call	SYM(<alloc[CRATE_ID]::alloc::Global>, 0)
	mov	rbx, qword ptr [r14 + 16]
	jmp	LBB19_11

	.p2align	4, 0x90
SYM(<alloc::string::String as core::fmt::Write>::write_str::GENERATED_ID, 0):
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r12
	push	rbx
	mov	r14, rdx
	mov	r15, rsi
	mov	r12, rdi
	mov	rax, qword ptr [rdi + 8]
	mov	rbx, qword ptr [rdi + 16]
	sub	rax, rbx
	cmp	rax, rdx
	jb	LBB20_1
LBB20_2:
	mov	rdi, qword ptr [r12]
	add	rdi, rbx
	mov	rsi, r15
	mov	rdx, r14
	call	_memcpy
	add	rbx, r14
	mov	qword ptr [r12 + 16], rbx
	xor	eax, eax
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	pop	rbp
	ret
LBB20_1:
	mov	rdi, r12
	mov	rsi, rbx
	mov	rdx, r14
	call	SYM(<alloc[CRATE_ID]::alloc::Global>, 0)
	mov	rbx, qword ptr [r12 + 16]
	jmp	LBB20_2

	.globl	_get_class
	.p2align	4, 0x90
_get_class:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::REGISTER_CLASS, 0)]
	cmp	rax, 3
	jne	LBB21_1
LBB21_2:
	lea	rdi, [rip + l_anon.[ID].52]
	mov	esi, 15
	call	SYM(objc2::runtime::Class::get::GENERATED_ID, 0)
	test	rax, rax
	je	LBB21_4
	add	rsp, 16
	pop	rbp
	ret
LBB21_1:
	mov	byte ptr [rbp - 1], 1
	lea	rax, [rbp - 1]
	mov	qword ptr [rbp - 16], rax
	lea	rdi, [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::REGISTER_CLASS, 0)]
	lea	rcx, [rip + l_anon.[ID].24]
	lea	r8, [rip + l_anon.[ID].51]
	lea	rdx, [rbp - 16]
	xor	esi, esi
	call	SYM(std::sync::once::Once::call_inner::GENERATED_ID, 0)
	jmp	LBB21_2
LBB21_4:
	lea	rdi, [rip + l_anon.[ID].26]
	lea	rdx, [rip + l_anon.[ID].51]
	mov	esi, 43
	call	SYM(core::panicking::panic::GENERATED_ID, 0)

	.globl	_get_obj
	.p2align	4, 0x90
_get_obj:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	mov	r14, qword ptr [rip + SYM(objc2::__macro_helpers::new_sel::CACHED_SEL::GENERATED_ID, 0)@GOTPCREL]
	mov	rbx, qword ptr [r14]
	test	rbx, rbx
	jne	LBB22_2
	lea	rdi, [rip + L_anon.[ID].49]
	call	SYM(objc2::runtime::Sel::register_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	qword ptr [r14], rax
LBB22_2:
	call	_get_class
	mov	rdi, rax
	mov	rsi, rbx
	pop	rbx
	pop	r14
	pop	rbp
	jmp	_objc_msgSend

	.globl	_access
	.p2align	4, 0x90
_access:
	push	rbp
	mov	rbp, rsp
	call	_get_obj
	mov	rcx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::ivar1>::__offset_ptr::OFFSET, 0)]
	movzx	ecx, byte ptr [rax + rcx]
	mov	rdx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::ivar2>::__offset_ptr::OFFSET, 0)]
	mov	rdx, qword ptr [rax + rdx]
	mov	eax, ecx
	pop	rbp
	ret

	.globl	SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class, 0)
	.p2align	4, 0x90
SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class, 0):
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::REGISTER_CLASS, 0)]
	cmp	rax, 3
	jne	LBB24_1
LBB24_2:
	lea	rdi, [rip + l_anon.[ID].52]
	mov	esi, 15
	call	SYM(objc2::runtime::Class::get::GENERATED_ID, 0)
	test	rax, rax
	je	LBB24_4
	add	rsp, 16
	pop	rbp
	ret
LBB24_1:
	mov	byte ptr [rbp - 1], 1
	lea	rax, [rbp - 1]
	mov	qword ptr [rbp - 16], rax
	lea	rdi, [rip + SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::REGISTER_CLASS, 0)]
	lea	rcx, [rip + l_anon.[ID].24]
	lea	r8, [rip + l_anon.[ID].51]
	lea	rdx, [rbp - 16]
	xor	esi, esi
	call	SYM(std::sync::once::Once::call_inner::GENERATED_ID, 0)
	jmp	LBB24_2
LBB24_4:
	lea	rdi, [rip + l_anon.[ID].26]
	lea	rdx, [rip + l_anon.[ID].51]
	mov	esi, 43
	call	SYM(core::panicking::panic::GENERATED_ID, 0)

	.p2align	4, 0x90
SYM(<test_declare_class[CRATE_ID]::Custom>::__objc2_dealloc, 0):
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	rbx
	sub	rsp, 72
	mov	r14, rdi
	mov	rax, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::ivar2>::__offset_ptr::OFFSET, 0)]
	mov	rdi, qword ptr [rdi + rax]
	test	rdi, rdi
	je	LBB25_2
	call	_objc_release
LBB25_2:
	mov	rbx, qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::Custom>::__objc2_dealloc::CACHED_SEL, 0).0]
	test	rbx, rbx
	je	LBB25_3
	mov	r15, qword ptr [rip + SYM(<objc2::foundation::object::NSObject as objc2::class_type::ClassType>::class::CACHED_CLASS::GENERATED_ID, 0)@GOTPCREL]
	mov	rax, qword ptr [r15]
	test	rax, rax
	je	LBB25_5
LBB25_6:
	test	rax, rax
	je	LBB25_8
LBB25_7:
	mov	qword ptr [rbp - 72], r14
	mov	qword ptr [rbp - 64], rax
	lea	rdi, [rbp - 72]
	mov	rsi, rbx
	call	_objc_msgSendSuper
	add	rsp, 72
	pop	rbx
	pop	r14
	pop	r15
	pop	rbp
	ret
LBB25_3:
	lea	rdi, [rip + L_anon.[ID].53]
	call	SYM(objc2::runtime::Sel::register_unchecked::GENERATED_ID, 0)
	mov	rbx, rax
	mov	qword ptr [rip + SYM(<test_declare_class[CRATE_ID]::Custom>::__objc2_dealloc::CACHED_SEL, 0).0], rax
	mov	r15, qword ptr [rip + SYM(<objc2::foundation::object::NSObject as objc2::class_type::ClassType>::class::CACHED_CLASS::GENERATED_ID, 0)@GOTPCREL]
	mov	rax, qword ptr [r15]
	test	rax, rax
	jne	LBB25_6
LBB25_5:
	lea	rdi, [rip + l_anon.[ID].41]
	call	_objc_getClass
	mov	qword ptr [r15], rax
	test	rax, rax
	jne	LBB25_7
LBB25_8:
	lea	rax, [rip + l_anon.[ID].46]
	mov	qword ptr [rbp - 88], rax
	lea	rax, [rip + SYM(<&str as core[CRATE_ID]::fmt::Display>::fmt, 0)]
	mov	qword ptr [rbp - 80], rax
	lea	rax, [rip + l_anon.[ID].44]
	mov	qword ptr [rbp - 72], rax
	mov	qword ptr [rbp - 64], 2
	mov	qword ptr [rbp - 56], 0
	lea	rax, [rbp - 88]
	mov	qword ptr [rbp - 40], rax
	mov	qword ptr [rbp - 32], 1
	lea	rsi, [rip + l_anon.[ID].48]
	lea	rdi, [rbp - 72]
	call	SYM(core::panicking::panic_fmt::GENERATED_ID, 0)

	.globl	_class_method
	.p2align	4, 0x90
_class_method:
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.globl	_instance_method
	.p2align	4, 0x90
_instance_method:
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

	.section	__TEXT,__const
	.p2align	3
l_anon.[ID].0:
	.byte	0

l_anon.[ID].1:
	.ascii	"Selector "

l_anon.[ID].2:
	.ascii	" accepts "

l_anon.[ID].3:
	.ascii	" arguments, but function accepts "

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].4:
	.quad	l_anon.[ID].1
	.asciz	"\t\000\000\000\000\000\000"
	.quad	l_anon.[ID].2
	.asciz	"\t\000\000\000\000\000\000"
	.quad	l_anon.[ID].3
	.asciz	"!\000\000\000\000\000\000"

	.section	__TEXT,__const
l_anon.[ID].5:
	.ascii	"$WORKSPACE/objc2/src/declare.rs"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].6:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000m\001\000\000\t\000\000"

	.section	__TEXT,__const
	.p2align	3
l_anon.[ID].7:
	.byte	17
	.space	39

l_anon.[ID].8:
	.ascii	"Failed to add method "

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].9:
	.quad	l_anon.[ID].8
	.asciz	"\025\000\000\000\000\000\000"

	.p2align	3
l_anon.[ID].10:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\213\001\000\000\t\000\000"

	.p2align	3
l_anon.[ID].11:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\322\001\000\000)\000\000"

	.p2align	3
l_anon.[ID].12:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\323\001\000\000;\000\000"

	.section	__TEXT,__const
l_anon.[ID].13:
	.ascii	"Failed to add ivar "

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].14:
	.quad	l_anon.[ID].13
	.asciz	"\023\000\000\000\000\000\000"

	.p2align	3
l_anon.[ID].15:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\337\001\000\000\t\000\000"

	.section	__TEXT,__const
l_anon.[ID].16:
	.ascii	"ivar1"

	.p2align	3
l_anon.[ID].17:
	.byte	5
	.space	39

l_anon.[ID].18:
	.ascii	"ivar2"

	.p2align	3
l_anon.[ID].19:
	.byte	19
	.space	39

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].20:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\244\001\000\000\t\000\000"

	.section	__TEXT,__const
l_anon.[ID].21:
	.ascii	"Failed to add class method "

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].22:
	.quad	l_anon.[ID].21
	.asciz	"\033\000\000\000\000\000\000"

	.p2align	3
l_anon.[ID].23:
	.quad	l_anon.[ID].5
	.asciz	"B\000\000\000\000\000\000\000\302\001\000\000\t\000\000"

	.p2align	3
l_anon.[ID].24:
	.quad	SYM(core[CRATE_ID]::class_type::ClassType>::class::{closure#0}>::{closure#0}>, 0)
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	SYM(<<std[CRATE_ID]::sync::once::OnceState,)>>::call_once::{shim:vtable#0}, 0)
	.quad	SYM(<std[CRATE_ID]::class_type::ClassType>::class::{closure#0}>::{closure#0}, 0)

	.p2align	3
l_anon.[ID].25:
	.quad	SYM(core[CRATE_ID]::ptr::drop_in_place::<&usize>, 0)
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	SYM(<&usize as core[CRATE_ID]::fmt::Debug>::fmt, 0)

	.section	__TEXT,__const
l_anon.[ID].26:
	.ascii	"called `Option::unwrap()` on a `None` value"

l_anon.[ID].27:
	.ascii	"/rustc/897e37553bba8b42751c67658967889d11ecd120/library/std/src/sync/once.rs"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].28:
	.quad	l_anon.[ID].27
	.asciz	"L\000\000\000\000\000\000\000\024\001\000\000)\000\000"

	.section	__TEXT,__const
l_anon.[ID].29:
	.ascii	"called `Result::unwrap()` on an `Err` value"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].30:
	.quad	SYM(core[CRATE_ID]::ffi::c_str::NulError>, 0)
	.asciz	" \000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	SYM(<alloc::ffi::c_str::NulError as core::fmt::Debug>::fmt::GENERATED_ID, 0)

	.p2align	3
l_anon.[ID].31:
	.quad	SYM(core[CRATE_ID]::fmt::Error>, 0)
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	SYM(<core::fmt::Error as core::fmt::Debug>::fmt::GENERATED_ID, 0)

	.p2align	3
l_anon.[ID].32:
	.quad	SYM(core[CRATE_ID]::string::String>, 0)
	.asciz	"\030\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	SYM(<alloc::string::String as core::fmt::Write>::write_str::GENERATED_ID, 0)
	.quad	SYM(<alloc::string::String as core::fmt::Write>::write_char::GENERATED_ID, 0)
	.quad	SYM(<alloc[CRATE_ID]::fmt::Write>::write_fmt, 0)

	.section	__TEXT,__const
l_anon.[ID].33:
	.ascii	"a Display implementation returned an error unexpectedly"

l_anon.[ID].34:
	.ascii	"/rustc/897e37553bba8b42751c67658967889d11ecd120/library/alloc/src/string.rs"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].35:
	.quad	l_anon.[ID].34
	.asciz	"K\000\000\000\000\000\000\000\317\t\000\000\016\000\000"

	.p2align	3
l_anon.[ID].36:
	.quad	SYM(core[CRATE_ID]::string::String>, 1)
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_str, 0)
	.quad	SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_char, 0)
	.quad	SYM(<&mut alloc[CRATE_ID]::fmt::Write>::write_fmt, 0)

	.section	__TEXT,__const
l_anon.[ID].37:
	.ascii	"invalid args"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].38:
	.quad	l_anon.[ID].37
	.asciz	"\f\000\000\000\000\000\000"

	.section	__TEXT,__const
l_anon.[ID].39:
	.ascii	"/rustc/897e37553bba8b42751c67658967889d11ecd120/library/core/src/fmt/mod.rs"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].40:
	.quad	l_anon.[ID].39
	.asciz	"K\000\000\000\000\000\000\000\214\001\000\000\r\000\000"

	.section	__TEXT,__const
l_anon.[ID].41:
	.asciz	"NSObject"

	.section	__TEXT,__literal16,16byte_literals
L_anon.[ID].42:
	.ascii	"Class with name "

	.section	__TEXT,__const
l_anon.[ID].43:
	.ascii	" could not be found"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].44:
	.quad	L_anon.[ID].42
	.asciz	"\020\000\000\000\000\000\000"
	.quad	l_anon.[ID].43
	.asciz	"\023\000\000\000\000\000\000"

	.section	__TEXT,__literal8,8byte_literals
L_anon.[ID].45:
	.ascii	"NSObject"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].46:
	.quad	L_anon.[ID].45
	.asciz	"\b\000\000\000\000\000\000"

	.section	__TEXT,__const
l_anon.[ID].47:
	.ascii	"$WORKSPACE/objc2/src/foundation/object.rs"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].48:
	.quad	l_anon.[ID].47
	.asciz	"L\000\000\000\000\000\000\000\030\000\000\000\t\000\000"

	.section	__TEXT,__literal4,4byte_literals
L_anon.[ID].49:
	.asciz	"new"

	.section	__TEXT,__const
l_anon.[ID].50:
	.ascii	"crates/$DIR/lib.rs"

	.globl	SYM(<test_declare_class[CRATE_ID]::ivar1>::__offset_ptr::OFFSET, 0)
.zerofill __DATA,__common,SYM(<test_declare_class[CRATE_ID]::ivar1>::__offset_ptr::OFFSET, 0),8,3
	.globl	SYM(<test_declare_class[CRATE_ID]::ivar2>::__offset_ptr::OFFSET, 0)
.zerofill __DATA,__common,SYM(<test_declare_class[CRATE_ID]::ivar2>::__offset_ptr::OFFSET, 0),8,3
	.section	__DATA,__const
	.p2align	3
l_anon.[ID].51:
	.quad	l_anon.[ID].50
	.asciz	"5\000\000\000\000\000\000\000\r\000\000\000\001\000\000"

	.section	__TEXT,__const
l_anon.[ID].52:
	.ascii	"CustomClassName"

.zerofill __DATA,__bss,SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::REGISTER_CLASS, 0),8,3
	.section	__TEXT,__literal8,8byte_literals
L_anon.[ID].53:
	.asciz	"dealloc"

	.section	__TEXT,__const
l_anon.[ID].54:
	.asciz	"classMethod"

l_anon.[ID].55:
	.asciz	"instanceMethod"

l_anon.[ID].56:
	.ascii	"could not create new class "

l_anon.[ID].57:
	.ascii	". Perhaps a class with that name already exists?"

	.section	__DATA,__const
	.p2align	3
l_anon.[ID].58:
	.quad	l_anon.[ID].56
	.asciz	"\033\000\000\000\000\000\000"
	.quad	l_anon.[ID].57
	.asciz	"0\000\000\000\000\000\000"

	.p2align	3
l_anon.[ID].59:
	.quad	l_anon.[ID].52
	.asciz	"\017\000\000\000\000\000\000"

.zerofill __DATA,__bss,SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 0).0,8,3
.zerofill __DATA,__bss,SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 1).0,8,3
.zerofill __DATA,__bss,SYM(<test_declare_class[CRATE_ID]::class_type::ClassType>::class::{closure#0}::CACHED_SEL, 2).0,8,3
.zerofill __DATA,__bss,SYM(<test_declare_class[CRATE_ID]::Custom>::__objc2_dealloc::CACHED_SEL, 0).0,8,3
.subsections_via_symbols
