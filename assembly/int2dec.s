.globl _start

.data

var8:	.byte	0x5d
var16:	.word	0xab89
var32:	.long	0x10abcdef
var64:	.quad	0xffffffffffffffff

outstr:	.ascii	"val = 00000000000000000000\n"
.equ	strlen, . - outstr
  
 .text
	
_start:

	xor	%eax,%eax

	mov	var64,%rax
	mov	$outstr+25,%rdi

	call	convert_dec

	mov	$1,%eax
	mov	$1,%edi
	mov	$outstr,%rsi
	mov	$strlen,%edx
	syscall

	mov	$60,%eax
	xor	%edi,%edi
	syscall

convert_dec:

mov $10, %ebx

do_while:

xor %edx, %edx
div %rbx 
add $48, %dl
mov %dl, (%rdi)
dec %rdi
#cmp $0, %rax
test %rax, %rax
jnz do_while
	ret
