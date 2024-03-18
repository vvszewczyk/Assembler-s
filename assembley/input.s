.global main

.data

	przestrzen1: .space 10
	format: .string "%s\n"
	#przestrzen2: .space 10
	dlugosc: .int 10


.text
main:
	mov 8(%rsi), %rax
	mov %rax, przestrzen1
	
	#mov 16(%rsi), %rax DRUGA ZMIENNA
	#mov %rax, przestrzen2
	#mov $60, %rax
	#mov $0, %rdi ZAMIAST TEGO JEST ret
	
	
	sub $8, %rsp
	
	mov $format, %rdi
	mov przestrzen1, %rsi
	call printf
	
	add $8, %rsp
	ret
	
	
	
	
	
	

