	global main
	extern printf			; c printf() fnc

	section	.text
main:
	push 	rbp			;
	mov	rbp, rsp			;
	and	rsp, -16			; Ensure allignment of stack pointer (ends with 0x...0)

	lea	rdi, [rel message]		; ptr to message as first arg (rdi)
	xor	rax, rax			; cleat AL (part of rax) to indicate no vector register argument 
	call	[rel printf WRT ..got]	; print

piStart:
	cvtsi2sd	xmm0, [rel double0]	; Iteration sum
	cvtsi2sd	xmm1, [rel double1]	; Divident (this/...)
	cvtsi2sd	xmm2, [rel double1]	; Divisor (.../this)
	cvtsi2sd	xmm3, [rel double2]	; const 2
	cvtsi2sd	xmm4, [rel double1]	; Const 1
	cvtsi2sd	xmm5, [rel doubleN]	; Const -1
	mov	R10, 0		; Iteration index

piIter:
	divpd	xmm1, xmm2	; 1/x 
	addpd	xmm0, xmm1	; add result to sum
	movapd	xmm1, xmm5	; reset divident to -1
	addpd	xmm2, xmm3	; x += 2

	divpd	xmm1, xmm2	; -1/x
	addpd	xmm0, xmm1	; add result to sum
	movapd	xmm1, xmm4	; reset divident to 1
	addpd	xmm2, xmm3	; x += 2
	
	inc	R10		; Finish iteration
	cmp	R10, 1000000	; More then 100 iters?
	jl 	piIter		; if not, repeat

piFin:
	mulpd	xmm0, xmm3		; 
	mulpd	xmm0, xmm3		; Multiply sum by 4 (*2*2) to get pi

	lea	rdi, [rel output]		; ptr to message as first arg (rdi)
	mov	rax, 1			; indicate 1 vector register argument 
	
	call	[rel printf WRT ..got]	; print
	
end:		
	mov	rsp, rbp			; 
	pop	rbp			; Reset stack pointer from prev. allignment

	xor	rax, rax			; return code 0 (equal to mov rax, 0)
	ret

	section	.data
message:	db	"PI: ", 0x0
output:	db	"%.6f", 0XA, 0x0
double0:	dd	0
double1:	dq	1
doubleN:	dq	-1
double2:	dq	2