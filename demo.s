	.file	"demo.c"
	.text
	.globl	global_data
	.data
	.align 4
	.type	global_data, @object
	.size	global_data, 4
global_data:
	.long	42
	.globl	global_bss
	.bss
	.align 4
	.type	global_bss, @object
	.size	global_bss, 4
global_bss:
	.zero	4
	.globl	message
	.section	.rodata
.LC0:
	.string	"Hello from .rodata!"
	.section	.data.rel.local,"aw"
	.align 8
	.type	message, @object
	.size	message, 8
message:
	.quad	.LC0
	.section	.rodata
.LC1:
	.string	"Counter: %d\n"
	.text
	.globl	counter
	.type	counter, @function
counter:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	count.1(%rip), %eax
	addl	$1, %eax
	movl	%eax, count.1(%rip)
	movl	count.1(%rip), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	counter, .-counter
	.section	.rodata
.LC2:
	.string	"Finalizing..."
	.text
	.globl	finalize
	.type	finalize, @function
finalize:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	finalize, .-finalize
	.section	.fini_array,"aw"
	.align 8
	.quad	finalize
	.section	.rodata
.LC3:
	.string	"Initializing..."
	.text
	.globl	initialize
	.type	initialize, @function
initialize:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	initialize, .-initialize
	.section	.init_array,"aw"
	.align 8
	.quad	initialize
	.text
	.globl	print_message
	.type	print_message, @function
print_message:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	message(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	print_message, .-print_message
	.section	.rodata
.LC4:
	.string	"Global Data: %d\n"
.LC5:
	.string	"Global BSS: %d\n"
.LC6:
	.string	"Local Static: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	global_data(%rip), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	global_bss(%rip), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	local_static.0(%rip), %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	call	print_message
	movl	$0, -4(%rbp)
	jmp	.L6
.L7:
	movl	$0, %eax
	call	counter
	addl	$1, -4(%rbp)
.L6:
	cmpl	$2, -4(%rbp)
	jle	.L7
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.local	count.1
	.comm	count.1,4,4
	.data
	.align 4
	.type	local_static.0, @object
	.size	local_static.0, 4
local_static.0:
	.long	100
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
