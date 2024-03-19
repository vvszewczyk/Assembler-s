.globl gcd

.text

.type	gcd,@function

gcd:


push	%rsi
push	%rdi
call	print_call_rsp
pop	%rdi
pop	%rsi

 
 
 or %esi, %esi
 jz gcd_end
 xor %edx, %edx 
 mov %edi, %eax
 div %esi
 mov %esi, %edi
 mov %edx, %esi



call	gcd

gcd_end:


push	%rsi
push	%rdi
call	print_ret_rsp
pop	%rdi
pop	%rsi

mov	%edi,%eax
ret

