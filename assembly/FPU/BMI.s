.global main
.data

# Wartosc poczatkowe zmiennych

mass:		.double	0.0
height:	.double	0.0
bmi:		.double	0.0
cw:		.word 0
outstr:	.string "BMI = %lf\n"


.text
main:
sub	$8,%rsp

# Ustaw podwojna precyzje obliczen, wylacz wyjatki


finit
fstcw	cw
	movw $0b0000001101111111, cw
fldcw	cw



# Oblicz BMI
# bmi = mass / height^2
	mov %rsi, %rbx
	
	cmp $3, %edi 		#porownanie dla 2 argumentow podanych z klawiatury
	jne wyjscie		#jump if not equal 3
	
	mov 8(%rbx), %rdi
	xor %rsi, %rsi
	call strtod		#strtof - string to float
	movsd %xmm0, mass
	
	mov 16(%rbx), %rdi
	xor %rsi, %rsi
	call strtod		#strtof dla string to float
	movsd %xmm0, height	#movss dla float
	
	

	fldl height		#flds dla float, zaladuj na wierzcholek stosu
	fmull height		#fmuls - mnozenie st(0) przez arguemnt podany w poleceniu
	
	fldl mass		#flds dla float, zaladuj mass na wierzcholek stosu do st(0)
	fdiv %st(1)		#podziel wierzcholek stosu przez argument: st(0)/st(1), jak daje float to fdivs, jak doublea to fdivl a, jak stos to po prostu fdiv
	
	fstl bmi		#fsts dla float, zapisanie st(0) do zmiennej


# Zapisz BMI i wydrukuj jego wartosc (jako double).


	mov $outstr, %rdi	
	mov $1, %rax
	movsd bmi, %xmm0		#movss dla floata
	#cvtss2sd %xmm0, %xmm0		#ta komenda dla floata a jak nie ma to nie uzywac
	call printf


wyjscie:
	add	$8,%rsp
ret
