.global main
.data 
	liczba1: .int 0
	liczba2: .int 0
	napis: .string "Nie prawidlowa ilosc argumentow\n"
	formatWyswietlenia: .string "Suma %d \n"
	wynikSumy: .int 0
	
.text
main:

	cmp $3, %edi #do edi jest wlozona ilosc argumentow
	jne argError #jump if not equal (jezeli nie ma 3 arguemntow to skocz do argError)
	sub $8, %rsp
	
	mov %rsi, %rbx
	
	mov 8(%rbx), %rdi 	#w przesunieciu bitowym rejestrem zawsze jest %rdi
	call atoi
	mov %eax, liczba1	#zapisanie wyniku atoi w liczba1
	
	
	mov 16(%rbx), %rdi
	call atoi
	mov %eax, liczba2
	
	mov liczba1, %rdi
	mov liczba2, %rsi
	call suma 	#wezwanie funkcji z C
	mov %rax, wynikSumy
	
	mov $formatWyswietlenia, %rdi
	mov wynikSumy, %rsi
	call printf
	add $8, %rsp
	
	jmp wyjscie
	
	
argError:
	mov $1, %rax
	mov $1, %rdi
	mov $napis, %rsi
	mov $32, %rdx
	syscall
	
wyjscie:
	ret
#	sudo as atoi.s -o atoi.o
#	sudo gcc -c atoi.c -o atoiC.o
#	sudo gcc atoi.o atoiC.o -o wynik -no-pie

