.globl print_call_rsp
.globl print_ret_rsp


.data
cntr:		.long	0
outstr1:	.ascii	"rsp=%lx call counter = %d\n\0"
outstr2:	.ascii	"rsp=%lx ret  counter = %d\n\0"

.text

.type	print_call_rsp,@function
.type	print_ret_rsp,@function

print_call_rsp:

mov	cntr,%edx
inc	%edx
mov	%edx,cntr
mov	$outstr1,%rdi

jmp	print_rsp


print_ret_rsp:

mov	cntr,%edx
decl	cntr
mov	$outstr2,%rdi


print_rsp:

lea	8(%rsp),%rsi
sub	$8,%rsp
xor	%eax,%eax
call	printf@plt
add	$8,%rsp
ret



