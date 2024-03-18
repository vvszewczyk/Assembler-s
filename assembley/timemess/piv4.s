.globl	main

#Liczba sumowanych czworek (+ i -) elementow.

.equ	N , 50000000

.data

timetab:	.double	0.0, 0.0, 0.0

str1: .string " PI_com = %3.20lf\n"
str2:	.string "USER CPU TIME = %lf s\n"

.align  32
suma:		.double   0.0, 0.0, 0.0, 0.0
mianownik:	.double  1.0, 3.0, 5.0, 7.0
licznik:	.double   4.0, -4.0, 4.0, -4.0
plus_8:	.double   8.0, 8.0, 8.0, 8.0

.text

main:

sub	$8 , %rsp

mov  $N , %rcx

vxorpd		%xmm0 , %xmm0 , %xmm0	#suma = 0
vmovapd	licznik , %ymm1
vmovapd	mianownik , %ymm2
vmovapd	plus_8 , %ymm3


for:

vdivpd		%ymm2 , %ymm1 , %ymm4		#%ymm4 = licznik / mianownik
vaddpd		%ymm4 , %ymm0 , %ymm0		#suma += %ymm4
vaddpd		%ymm3 , %ymm2 , %ymm2		#mianownik += 8.0

dec %rcx
jnz for

vhaddpd	%ymm0 , %ymm0 , %ymm0
vextractf128	$1 , %ymm0 , %xmm1
vaddpd		%xmm0 , %xmm1 , %xmm2
movsd		%xmm2 , suma


mov	$timetab , %rdi
call	read_time


mov   $str1,%rdi
movsd suma,%xmm0
mov   $1,%eax
call  printf

mov	$str2,%rdi
movsd	timetab+8,%xmm0
mov   $1,%eax
call	printf

add	$8,%rsp
ret
