.global main

.data
	liczba: .int 0
	tekst: .string "Nieprawidlowa ilosc argumentow\n"
	format: .string "Liczba %d\n"
	
.text
main:
	cmp $2, %edi
	jne errorArg
	mov %rsi, %rbx
	
	sub $8, %rsp
	
	mov 8(%rbx), %rdi
	call atoi
	
	
	cmp $1, %rax
	je case1
	
	cmp $2, %rax
	je case2
	
	cmp $3, %rax
	je case3
	
	jne caseDef
	
	
case1:
	mov $1, %rsi
	mov $format, %rdi
	call printf
	jmp exit
case2:
	mov $2, %rsi
	mov $format, %rdi
	call printf
	jmp exit
case3:
	mov $3, %rsi
	mov $format, %rdi
	call printf
	jmp exit
caseDef:
	mov $100, %rsi
	mov $format, %rdi
	call printf
	jmp exit
	
	add $8, %rsp
	
errorArg:
	mov $1, %rax
	mov $1, %rdi
	mov $tekst, %rsi
	mov $32, %rdx
	syscall
	jmp wyjscie

wyjscie:
	ret
