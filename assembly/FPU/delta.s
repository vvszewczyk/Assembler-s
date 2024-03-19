.global main
.data
	a: .float 0.0
	b: .float 0.0
	c: .float 0.0
	delta: .float 0.0
	bufor: .float 4.0
	format: .string "Delta: %f\n"
	cw: .word 0
.text
main:
	sub $8, %rsp
	finit				#defaultujemy FPU
	fstcw cw 			#zapisujemy ustawienia FPU do zmiennej cw -> cw: .word 0
	movw $0b0000000001111111, cw	#zapisujemy nowe control word do cw. Instrukcja robienia control word nizej
	fldcw cw			#wczytujemy control word z cw do FPU	

	mov %rsi, %rbx
	
	cmp $4, %edi 		#porownanie dla 2 argumentow podanych z klawiatury
	jne wyjscie		#jump if not equal 3
	
	mov 8(%rbx), %rdi
	xor %rsi, %rsi
	call strtof		#strtof - string to float
	movss %xmm0, a
	
	mov 16(%rbx), %rdi
	xor %rsi, %rsi
	call strtof		#strtof dla string to float
	movss %xmm0, b	#movss dla float
	
	mov 24(%rbx), %rdi
	xor %rsi, %rsi
	call strtof		#strtof dla string to float
	movss %xmm0, c	#movss dla float
	
	
	flds bufor
	fmuls a
	fmuls c #4ac
	
	flds b
	fmuls b #b^2
	
	fsub %st(1) #b^2-4ac
	fsts delta

	
	mov $format, %rdi
	mov $1, %rax
	movss delta, %xmm0
	cvtss2sd %xmm0, %xmm0
	call printf

wyjscie:
	add $8, %rsp

ret
