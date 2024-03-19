.globl _start

.equ	sys_write,	1 
.equ	sys_exit,	60
.equ	stdout,	1
.equ	strlen, 	new_line + 1 - str


.data

str:		.ascii	"Hello!"
new_line:	.byte	0x0A #poczatek nowej linii /n

.text

_start:

mov	$sys_write , %eax #ta 1 sluzy do wypisywania do konsoli, moze byc zamienne eax z rax
mov	$stdout , %edi #to jest jakis tryb wypisywania arg0 u nas 1
mov	$str , %esi #arg1 wlozenie napisu
mov	$strlen , %edx #przekazujemy dlugosc napisu (tego powyzszego)
syscall
mov $60, %eax #wejdz do exit
mov $0, %edi# to mowi z jakim kodem ma wyjsc
syscall
