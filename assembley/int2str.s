.globl _start

.data

var8:	.byte	93
var16:	.word	51966
var32:	.long	3735927486
var64:	.quad	18369548392556473261

outstr:	.ascii	"value = 0x0000000000000000\n"
.equ	strlen, . - outstr

  
 .text
	
_start:

	xor	%eax,%eax	

	mov	var64,%rax
	mov	$outstr+24,%rdi

	mov	$8,%ecx

	call	convert	

	mov	$1,%eax
	mov	$1,%edi
	mov	$outstr,%rsi
	mov	$strlen,%edx
	syscall

	mov	$60,%eax
	xor	%edi,%edi
	syscall

convert:

mov %rax, %rdx

	call	convert_byte
mov %rdx, %rax
shr $8, %rax
sub $2, %rdi
dec %ecx
jnz convert

	ret

convert_byte:

mov %al, %ah
and $0x0F, %al
#call zaklada adres powrotny na stos
	call	convert_nibble
xchg %al, %ah #zamiana mlodszego ze starszym bitem (mlodszy do ah starszy do al) 
shr $4, %al #przesuniecie o 4 bity
call convert_nibble
mov %ax, (%rdi)

	ret
	
	
	
convert_nibble: #konwersja polowki bajta

cmp $10, %al #porownaj akumulator z 10
jb below_10
add $55, %al
	ret
below_10:
	add $48, %al
	ret
