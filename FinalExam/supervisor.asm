; // Juan Uriarte
; // CPSC240-1
; // Final Program Test
; // uriarte.juan@csu.fullerton.edu


extern printf
extern scanf
extern fillarray
extern printArray
extern hsum

global supervisor

TITLE_LEN equ 50

segment .data

prompt db "Please input the count of number of data items to be placed into the array with (maximum 10 million): ", 0

intformat db "%ld", 0

hsumstuff db "THIS IS HSUM", 10, 0

hmean db "THIS IS HMEAN", 10, 0

beginningtic db "The time is now %lu tics.  Sorting will begin.", 10, 0

endingtic db "The time is now %lu tics.  Sorting has finished.", 10, 0

sortTime db "Total sort time is %lu tics which equals %.9lf seconds.", 10, 0

endl db "",10,0

segment .bss

myArray resq 10000000
;arrayinput resq 50

segment .text

supervisor:

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

;print prompt
mov rax, 0
mov rdi, prompt
call printf

;call scanf
sub rsp, 1024
mov rax, 0
mov rdi, intformat
mov rsi, rsp
call scanf
mov r15, [rsp]
add rsp, 1024

;call fillarray
mov rax, 0
mov rdi, myArray
mov rsi, r15
call fillarray
mov r13, rax

mov r9, 3000000
cvtsi2sd xmm11, r9

divsd xmm12, xmm11

mov rax, 0
mov rdi, myArray
mov rsi, r13
call printArray

mov rax, 0  ;lets user know that hsum is printing
mov rdi, hsumstuff
call printf

mov rax, 0  ;puts a blank space below
mov rdi, endl
call printf

;call printArray
mov rax, 0      ;calls hsum
mov rdi, myArray
mov rsi, r13
call hsum

;;call printArray
;mov rax, 0
;mov rdi, myArray
;mov rsi, r13
;call printArray


mov rax, 1      ;prints out hsum
mov rdi, intformat
movsd xmm0, xmm10
call printf

mov rax, 0  ;puts a blank space below
mov rdi, endl
call printf

mov rax, 0      ;lets user know that hmean is printing
mov rdi, hmean
call printf

mov rax, 0  ;puts a blank space below
mov rdi, endl
call printf

mov rax, 1      ;prints out hmean
mov rdi, intformat
cvtsi2sd xmm9, r13
divsd xmm10, xmm9
movsd xmm0, xmm10
call printf

mov rax, 0  ;puts a blank space below
mov rdi, endl
call printf

;get begin tic
;cpuid
;rdtsc
;shl rdx, 32
;add rdx, rax
;mov r12, rdx            ;r12 stores beginning tic

;print beginningtic
;mov rax, 0
;mov rdi, beginningtic
;mov rsi, r12
;call printf

;sort array
;mov rax, 0
;mov rdi, myArray
;mov rsi, r13
;call fsort

;get ending tic
;cpuid
;rdtsc
;shl rdx, 32
;add rdx, rax
;mov r11, rdx

;print endingtic
;mov rax, 0
;mov rdi, endingtic
;mov rsi, r11
;call printf

;calculate diference in tics
;mov r10, r12
;sub r10, r11

;mov rax, 0
;call getfreq
;movsd xmm15, xmm0

;cvtsi2sd xmm14, r12
;cvtsi2sd xmm13, r11

;subsd xmm14, xmm13

;movsd xmm12, xmm14

;divsd xmm12, xmm15

; Get value of 1 billion and store it in xmm11.
; mov rax, 0x41cdcd6500000000
; push rax
; movsd xmm11, [rsp]
; pop rax


;print sortTime
;mov rax, 1
;mov rdi, sortTime
;mov rsi, r10
;movsd xmm0, xmm12
;call printf

;call printArray


movsd xmm10, xmm12
movsd xmm0, xmm10

popf                                    ;Restore rflags
pop rbx                                 ;Restore rbx
pop r15                                 ;Restore r15
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

ret
