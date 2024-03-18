.global main
.data
	x1: .float 0.0 
	y1: .float 0.0
	x2: .float 0.0
	y2: .float 0.0
	length: .float 0.0
	format: .string "Dlugosc odcinka: %f\n"
	cw: .word 1

.text
main:
	sub $8, %rsp
	
	finit
	fstcw cw 
	movw $0b0000000001111111, cw
	fldcw cw
	
	mov %rsi, %rbx
	
	cmp $5, %edi
	jne wyjscie
	
	mov 8(%rbx), %rdi
	xor %rsi, %rsi
	call strtof
	movss %xmm0, x1
	
	mov 16(%rbx), %rdi
	xor %rsi, %rsi
	call strtof
	movss %xmm0, y1
	
	mov 24(%rbx), %rdi
	xor %rsi, %rsi
	call strtof
	movss %xmm0, x2
	
	mov 32(%rbx), %rdi
	xor %rsi, %rsi
	call strtof
	movss %xmm0, y2
	
	flds x1
	fsubs x2
	fmul %st(0)
	
	flds y1
	fsubs y2
	fmul %st(0)
	
	fadd %st(1)
	fsqrt
	fsts length
	

	mov $format, %rdi
	mov $1, %rax
	movss length, %xmm0
	cvtss2sd %xmm0, %xmm0
	call printf

wyjscie:
	add $8, %rsp

ret
