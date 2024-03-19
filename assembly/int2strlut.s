.globl _start


.data

lut16bit:
lut_0:	.ascii	"00","01","02","03","04","05","06","07","08","09","0A","0B","0C","0D","0E","0F"
lut_1:	.ascii	"10","11","12","13","14","15","16","17","18","19","1A","1B","1C","1D","1E","1F"
lut_2:	.ascii	"20","21","22","23","24","25","26","27","28","29","2A","2B","2C","2D","2E","2F"
lut_3:	.ascii	"30","31","32","33","34","35","36","37","38","39","3A","3B","3C","3D","3E","3F"
lut_4:	.ascii	"40","41","42","43","44","45","46","47","48","49","4A","4B","4C","4D","4E","4F"
lut_5:	.ascii	"50","51","52","53","54","55","56","57","58","59","5A","5B","5C","5D","5E","5F"
lut_6:	.ascii	"60","61","62","63","64","65","66","67","68","69","6A","6B","6C","6D","6E","6F"
lut_7:	.ascii	"70","71","72","73","74","75","76","77","78","79","7A","7B","7C","7D","7E","7F"
lut_8:	.ascii	"80","81","82","83","84","85","86","87","88","89","8A","8B","8C","8D","8E","8F"
lut_9:	.ascii	"90","91","92","93","94","95","96","97","98","99","9A","9B","9C","9D","9E","9F"
lut_A:	.ascii	"A0","A1","A2","A3","A4","A5","A6","A7","A8","A9","AA","AB","AC","AD","AE","AF"
lut_B:	.ascii	"B0","B1","B2","B3","B4","B5","B6","B7","B8","B9","BA","BB","BC","BD","BE","BF"
lut_C:	.ascii	"C0","C1","C2","C3","C4","C5","C6","C7","C8","C9","CA","CB","CC","CD","CE","CF"
lut_D:	.ascii	"D0","D1","D2","D3","D4","D5","D6","D7","D8","D9","DA","DB","DC","DD","DE","DF"
lut_E:	.ascii	"E0","E1","E2","E3","E4","E5","E6","E7","E8","E9","EA","EB","EC","ED","EE","EF"
lut_F:	.ascii	"F0","F1","F2","F3","F4","F5","F6","F7","F8","F9","FA","FB","FC","FD","FE","FF"

var8:	.byte	93
var16:	.word	51966
var32:	.long	3735927486
var64:	.quad	18369548392556473261

outstr:	.ascii	"value = 0x0000000000000000\n"
.equ	strlen, . - outstr

  
 .text
	
_start:

	xor	%eax,%eax
	

	mov	var64,%rax
	mov	$outstr+8,%rdi


	mov	$8,%ecx


	call	convert	


	mov	$1,%eax
	mov	$1,%edi
	mov	$outstr,%rsi
	mov	$strlen,%edx
	syscall


	mov	$60,%eax
	xor	%edi,%edi
	syscall


convert:

mov %rax, %rbx #mamy juz a i c czyli wzielismy np b czyli rbx
and $0xFF, %rax #wydlubanie najstaerszego bajtu  
mov lut16bit( , %rax, 2), %ax
mov %ax, outstr+8( , %ecx, 2) 
shr $8, %rbx
mov %rbx, %rax

	dec	%ecx #dekrementacja
	jnz	convert #jump if not 0

	ret
