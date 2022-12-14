; // Juan Uriarte
; // CPSC240-1
; // Final Program Test
; // uriarte.juan@csu.fullerton.edu

extern scanf
extern printf
extern isnan
; extern isinteger			;From isinteger.asm
; extern atolong				;From atol.asm
; extern printArray
global fillarray

section .data
	integerOutputFormat db "%ld", 10, 0
	stringOutputFormat db "%s", 0
	;controlDPressed db "Control D is pressed.", 10, 0
	;overloadStatement db "You have reached the maximum elements in the array.", 10, 0
	;invalidType db "One or more numbers were invalid and were omitted from the array.", 10, 0

section .bss
	;Nothing declared inside .bss

section .text
fillarray:

push rbp                                          ;Backup rbp
mov  rbp,rsp                                      ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push r15                                          ;Backup r15
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

	mov r14, rdi		;r14 has the pointer to the array in supervisor.asm
	mov r13, rsi		;r13 holds array capacity stored in rsi
	mov r12, 0		;r12 represents current index of array

startOfLoop:
    
    rdrand r15
	cvtsi2sd xmm15, r15

    mov rax, 0
    movsd xmm0, xmm15
    call isnan

    cmp rax, 1
    je startOfLoop

    movsd [r14+8*r12], xmm15
    inc r12
    cmp r12, r13
    je exitProgram
    jmp startOfLoop

exitProgram:


mov qword rax, r12				;Backing up r12 into rax to be returned

	;Popping all of registers in reverse order as pushes
	pop rbx                                                     ;Restore rbx
	pop r15                                                     ;Restore r15
	pop r14                                                     ;Restore r14
	pop r13                                                     ;Restore r13
	pop r12                                                     ;Restore r12
	pop r11                                                     ;Restore r11
	pop r10                                                     ;Restore r10
	pop r9                                                      ;Restore r9
	pop r8							    ;Restore r8
	pop rcx                                                     ;Restore rcx
	pop rdx                                                     ;Restore rdx
	pop rsi                                                     ;Restore rsi
	pop rdi                                                     ;Restore rdi
	pop rbp                                                     ;Restore rbp
	pop rbx

	ret                                               ;Returning current number of items in array
