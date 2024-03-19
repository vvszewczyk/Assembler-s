.globl	main

# Liczba sumowanych par (+ i -) elementow.

.equ	N , 1000000000

.data

timetab:	.double	0.0, 0.0, 0.0
cw:		.word		0
str1:		.string	" PI_ref =\t%1.20Lf\n PI_com =\t%1.20Lf\n delta  =\t%1.20Lf\n"
str2:		.string	"USER CPU TIME = %lf s\n"

.text

main:                

sub	$8 , %rsp

# Rozpocznij pomiar czasu

call	init_time

mov	$N , %rcx

finit

fstcw	cw
andw	$0xf0ff , cw
orw	$0x0000 , cw
fldcw	cw


fldz #st(0)=0.0 suma
fld1 #st(0)=1.0 st(1)=0.0 suma
fadd %st(0), %st(0) #st(1)=0.0 -suma st(0)-2.0 stala
fld1 #st(0) = 1.0 - mianownik, st(1)=2.0 -stala st(2)=0.0 - suma

for:

#ZAWSZE JEDNYM Z ARGUMENTOW MUSI BYC ST(0)!!!!!!!!!!!

fld1 #st(0)=1.0 licznik, st(1)=mianownik, st(2)=stala 2.0, st(3)=suma
fdiv %st(1), %st(0) #st(0)=st(0)/st(1)
faddp %st(0), %st(3)   #st(3)=St(0)+st(3), pop st(0)->st(2)=suma+obliczony element, st(2) - suma, st(1)=2.0, st(0) - mianownik
fadd %st(1), %st(0)

fld1
fdiv %st(1), %st(0)
fsubrp %st(0), %st(3)
fadd %st(1), %st(0)


dec	%rcx
jnz	for    


fxch %st(2) #zamien wierzcholek stosu z rejestrem wskazanym
fadd %st(0), %st(0)
fadd %st(0), %st(0)

fldpi
fsub	%st(1) , %st(0)
fabs

# Wrzuc wszystko na stos

sub	$16 , %rsp
fstpt	(%rsp)

sub	$16 , %rsp
fstpt	(%rsp)

fldpi
sub	$16 , %rsp
fstpt	(%rsp)

# Zakoncz pomiar czasu

mov	$timetab , %rdi
call	read_time

mov	$str1 , %rdi
xor	%eax , %eax
call	printf

mov	$str2 , %rdi
movsd	timetab+8 , %xmm0
xor	%eax , %eax
inc	%eax
call	printf

add	$56 , %rsp
ret
