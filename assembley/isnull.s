.globl main

.data
	tab: .long 6, 4, 0, 0, 0, 0, 3, 0, 0, 9, 0, 0, 8, 1, 1
	.equ liczba_elementow, 15
	str: .asciz  "%u elementow zerowych\n"
	wynik: .int 0
	index: .int 0
	
.text
main:
	sub $8, %rsp
	cmp $2, %edi
	jne wyjscie

	mov %rsi, %rbx
	
	mov 8(%rbx), %rdi
	call atoi
	mov %eax, index
	cmp $15, %eax
	ja wyjscie
	cmp $0, %eax
	jbe wyjscie
	
	mov $tab, %rdi
	mov index, %rsi
	call isNULL
	mov %eax, wynik
	mov $str, %rdi
	mov wynik, %rsi
	
	call printf

	
wyjscie:
	add $8, %rsp
	ret
