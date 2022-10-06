	.section	__TEXT,__text,regular,pure_instructions
	.intel_syntax noprefix
	.globl	_null
	.p2align	4, 0x90
_null:
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	rax
	mov	qword ptr [rbp - 16], 0
	lea	rdx, [rbp - 16]
	call	_objc_msgSend
	mov	rbx, rax
	mov	rdi, qword ptr [rbp - 16]
	call	_objc_retain
	mov	rdx, rax
	mov	rax, rbx
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret

	.globl	_nonnull
	.p2align	4, 0x90
_nonnull:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	rbx
	push	rax
	mov	rbx, rdx
	mov	qword ptr [rbp - 32], rdx
	lea	rdx, [rbp - 32]
	call	_objc_msgSend
	mov	r14, rax
	mov	rdi, qword ptr [rbp - 32]
	call	_objc_retain
	mov	r15, rax
	mov	rdi, rbx
	call	_objc_release
	mov	rax, r14
	mov	rdx, r15
	add	rsp, 8
	pop	rbx
	pop	r14
	pop	r15
	pop	rbp
	ret

	.globl	_generic
	.p2align	4, 0x90
_generic:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	rbx
	push	rax
	mov	rbx, rdx
	mov	qword ptr [rbp - 32], rdx
	lea	rdx, [rbp - 32]
	call	_objc_msgSend
	mov	r14, rax
	mov	rdi, qword ptr [rbp - 32]
	call	_objc_retain
	mov	r15, rax
	test	rbx, rbx
	je	LBB2_2
	mov	rdi, rbx
	call	_objc_release
LBB2_2:
	mov	rax, r14
	mov	rdx, r15
	add	rsp, 8
	pop	rbx
	pop	r14
	pop	r15
	pop	rbp
	ret

.subsections_via_symbols
