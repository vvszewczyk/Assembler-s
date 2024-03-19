.globl	main

# Liczba sumowanych par (+ i -) elementow.

.equ	N , 100000000

.data

timetab:	.double	0.0, 0.0, 0.0
mxcsr:	.long	0
str1: .string " PI_com = %3.20lf\nUSER CPU TIME = %lf s\n"

.align  16

suma:		.double   0.0, 0.0
mianownik:	.double   1.0, 3.0
licznik:	.double   4.0, -4.0
plus_4:	.double   4.0, 4.0

.text

main:

sub	$8 , %rsp

# Rozpocznij pomiar czasu

call	init_time

mov  $N , %rcx


stmxcsr	mxcsr
andl	$0xFFFF9FFF , mxcsr
orl	$0x00000000 , mxcsr
ldmxcsr	mxcsr

# Wartosci poczatkowe rejestrow

movapd   suma , %xmm0
movapd   licznik , %xmm1
movapd   plus_4,  %xmm2
movapd   mianownik , %xmm3
movapd   %xmm1 , %xmm4		#kopia licznika


for:
divpd	%xmm3 , %xmm1	# licznik = licznik / mianownik
addpd	%xmm2 , %xmm3	# mianownik += 2.0
addpd	%xmm1 , %xmm0	# suma += licznik / mianownik
movapd	%xmm4 , %xmm1	# przywroc licznik 


dec	%rcx
jnz	for

haddpd %xmm0, %xmm0


movsd	%xmm0 , suma


mov	$timetab , %rdi
call	read_time

mov	$str1 , %rdi
movsd	suma , %xmm0
movsd	timetab+8 , %xmm1
mov	$2 , %eax
call	printf

add	$8 , %rsp
ret
