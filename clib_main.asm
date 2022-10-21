	global main
	extern printf		; c printf() fnc

	section	.text
main:
	lea	rdi, [rel message]	; ptr to message as first arg (rdi)
	xor	rax, rax		; cleat AL (part of rax) to indicate no vector register argument 
				; https://stackoverflow.com/questions/6212665/why-is-eax-zeroed-before-a-call-to-printf

;	call 	printf WRT ..plt	
	call	[rel printf WRT ..got]
				; WRT = with respect to.
				; PLT stands for Procedure Linkage Table which is, put simply, used to call external 
				;  procedures/functions whose address isn't known in the time of linking, and is left 
				;  to be resolved by the dynamic linker at run time.
				; GOT stands for Global Offsets Table and is similarly used to resolve addresses. 
				;  Both PLT and GOT and other relocation information is explained in greater length in this article.
				; https://reverseengineering.stackexchange.com/questions/1992/what-is-plt-got

	xor	rax, rax		; return code 0 (equal to mov rax, 0)
	ret

	section	.data
message:
	db	"Hello C world", 0xA
