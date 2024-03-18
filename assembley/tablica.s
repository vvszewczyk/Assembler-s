.global main
.data
	arr: .double 1.0, 2.0
	format: .string "%lf\n"
	wynik: .double 0.0
.text
main:

	sub $8, %rsp
	
	mov $arr, %rdi
	mov $2, %rsi
	call exec
	movsd %xmm0, wynik
	
	
	mov $format, %rdi
	mov $1, %rax
	movsd wynik, %xmm0
	#cvtss2sd %xmm0, %xmm0
	call printf

	add $8, %rsp

	ret
