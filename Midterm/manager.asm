    ; Juan Uriarte
	; uriarte.juan@csu.fullerton.edu
	; October 12, 2022
	; Section ID: Section 1 

extern printf
extern scanf
extern get_data
extern Display
extern max
extern stdin
extern strchr
extern fgets

global manager

segment .data
user_name db "Please enter your name: ",10,0
present_numbers db "The numbers you entered are these: ",10,0
the_sum_is db "The max value is %.10lf.", 10 ,0
exit_message db "The control module will now return the sum to the caller module.",10,0
goodbye db "Thank you for using this software, %s ", 10, 0

segment .bss  ;Reserved for uninitialized data
the_array resq 6 ; array of 6 quad words reserved before run time.
name resb 30 ; name of user

segment .text ;Reserved for executing instructions.

manager:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0  ; remain on the boundary


;enter name print statement
push qword 0
mov rax, 0
mov rdi, user_name
call printf
pop rax

;input for entire name
mov rax, 0
mov rdi, name
mov rsi, 30
mov rdx,[stdin]
call fgets
;erases memory
mov rax, 0
mov rdi, name
mov rsi, 10
call strchr
mov byte[rax], 0

; Fill the array using the fill module
push qword 0
mov rax, 0
mov rdi, the_array ; array passed in as first param
mov rsi, 6        ; array size passed in as second param
call get_data
mov r15, rax
pop rax

;"The numbers you entered are these: "
push qword 0
mov rax, 0
mov rdi, present_numbers
call printf
pop rax
; Display the numbers in the_array using the Display module
push qword 0
mov rax, 0
mov rdi, the_array
mov rsi, r15
call Display
pop rax
; Computing the sumaxm...
push qword 0
mov rax, 0
mov rdi, the_array
mov rsi, 6
call max ;The max will be in xmm0
movsd xmm15, xmm0
pop rax

; The max of these values is ....
push qword 0
mov rax, 1
mov rdi, the_sum_is
movsd xmm0, xmm15
call printf
pop rax

; The max will be returned to the caller module
push qword 0
mov rax, 0
mov rdi, exit_message
call printf
pop rax



pop rax ; counter push at the beginning

mov rax, 1
mov rdi, goodbye
mov rsi, name
call printf

movsd xmm0, xmm15

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret