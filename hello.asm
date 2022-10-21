	global 	_start

	section 	.text
_start:	mov 	rax, 1	 	; syscall write
	mov 	rdi, 1	 	; file handle 1 = stdout
	mov 	rsi, message	; address of string
	mov 	rdx, 14	 	; number of bytes
	syscall

	mov 	rax, 60	 	; syscall exit
	mov 	rdi, 0	 	; code 0
	syscall

	section	.data
message:
	db	"Hello, World", 0xA, 0XD