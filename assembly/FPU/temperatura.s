.globl	main

.data

# Wartosc poczatkowa temperatury (tf) i niezbedne stale.

c32:		.float	32.0
tf:		.float	0.0
tc:		.float	0.0
piec:		.float 5.0
dziewiec:	.float 9.0

cw:		.word 0

outstr:	.string "Tc = %f\n"

.text

main:
sub	$8,%rsp

finit

# Ustaw pojedyncza precyzje obliczen, wylacz wyjatki

fstcw	cw
	movw $0b0000001101111111, cw
fldcw	cw


# Przelicz stopnie F (tf) na stopnie C (tc).
# tc = 5.0/9.0 * (tf - 32.0)
	mov %rsi, %rbx
	
	cmp $2, %edi 		#porownanie dla 2 argumentow podanych z klawiatury
	jne wyjscie		#jump if not equal 3
	
	mov 8(%rbx), %rdi
	xor %rsi, %rsi
	call strtof		#strtof - string to float
	movsd %xmm0, tf
	
	flds piec
	fdivs dziewiec #st(0)
	
	flds tf #st(0) st(1)=5/9
	fsub c32
	
	fmul %st(1)
	
	fsts tc


# Zapisz tc i wydrukuj wartosc temperatury w stopniach C (jako float).

	mov $outstr, %rdi	
	mov $1, %rax
	movss tc, %xmm0		#movss dla floata
	cvtss2sd %xmm0, %xmm0		#ta komenda dla floata a jak nie ma to nie uzywac
	call printf

wyjscie:
add	$8,%rsp
ret
