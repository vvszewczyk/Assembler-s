.globl _start

.equ	sys_write,	1
.equ	sys_exit,	60
.equ	stdout,	1
.equ	iterations,	5
.equ	strlen, 	new_line + 1 - str

.data

str:		.ascii	"iteracja nr: x"
new_line:	.byte	0x0A
counter:	.byte	0

.text

_start:

movb $1, counter
for_loop:

cmpb $13, counter #counter-13

ja for_exit
movb counter, %dl
add $48, %dl
mov %dl, str+13

mov	$sys_write , %eax
mov	$stdout , %edi
mov	$str , %esi
mov	$strlen , %edx
syscall

incb counter

jmp for_loop
for_exit:

mov	$sys_exit , %eax
xor	%edi , %edi
syscall
