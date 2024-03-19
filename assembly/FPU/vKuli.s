.global main
.data
	cztery: .double 4.0
	trzy: .double 3.0
	r: .double 0.0
	format: .string "V: %lf\n"
	v: .double 0.0
	cw: .word 0


.text
main:
	sub	$8,%rsp
	
	finit
	fstcw cw
	movw $0b0000001101111111, cw	
	fldcw cw
	
	mov %rsi, %rbx
	
	cmp $2, %edi
	jne wyjscie
	
	mov 8(%rbx), %rdi
	xor %rsi, %rsi
	call strtod
	movsd %xmm0, r
	
	
	fldl cztery
	fdivl trzy
	
	fldpi
	fmull r
	fmull r
	fmull r
	fmul %st(1) 	
	
	fstl v	
	
	
	mov $format, %rdi	
	mov $1, %rax
	movsd v, %xmm0
	call printf


wyjscie:
	add	$8,%rsp
ret
