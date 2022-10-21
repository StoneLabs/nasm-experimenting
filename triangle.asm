	global	start

	section	.text
start:
	mov	R10, output	; pointer to end of str
	mov	R8, 1		; current line length
	mov	R9, 0		; stars on this line
line:	
	mov	byte [R10], '*'	; add one star
	inc	R10		; 

	inc	R9		; one star added
	cmp	R8,R9		; was it last?
	jne	line
lineEnd:
	mov	byte [R10], 0xA	; add NL
	inc	R10

	mov	R9, 0		; reset stars on line
	inc	R8		; inc line count
	cmp	R8, maxlines
	jne	line
end:
	mov	rax, 1		; syscall write
	mov	rdi, 1		; file handle stdout
	mov	rsi, output	; output start byte
	mov	rdx, numBytes	; output byes
	syscall

	mov 	rax, 60	 	; syscall exit
	mov 	rdi, 0	 	; code 0
	syscall


	section .bss
maxlines	equ	8
numBytes	equ	2+3+4+5+6+7+8+9	; 1 star + NL to 8 stars + NL
output:	resb	numBytes