   ; Juan Uriarte
	; uriarte.juan@csu.fullerton.edu
	; October 12, 2022
	; Section ID: Section 1 


extern printf
global max

segment .data

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.
testing db "This is num: %.10lf.", 10, 0

max:

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

push qword 0 ; remain on the boundary
; Taking information from parameters
mov r15, rdi  ; This holds the first parameter (the array)
mov r14, rsi  ; This holds the second parameter (the number of elements in the array, not size)


; loop the array and add each value to a total.
mov rax, 1 ; one xmm register will be used
mov rdx, 0
cvtsi2sd xmm15, rdx ; convert the 0 in rdx to something xmm can read
mov r13, 0 ; for loop counter goes up to 5, starting at 0
movsd xmm15, [r15]
;movsd xmm14, [r15 + 8*1]
;movsd xmm13, [r15 + 8*2]
;movsd xmm12, [r15 + 8*3]
;movsd xmm11, [r15 + 8*4]
;movsd xmm10, [r15 + 8*5]

movsd xmm0, xmm15
beginLoop:
  cmp r13, r14  ;comparing increment with 6 (the size of array)
  je outOfLoop
  movsd xmm14, [r15 + 8*r13]
  ucomisd xmm14, xmm15; ;check if xmm14 is bigger
  jae big
  jb small

  big:
  movsd xmm0, xmm14
  movsd xmm15, xmm14
  inc r13
  jmp beginLoop

  small:
  movsd xmm0, xmm15
  movsd xmm14, xmm15
  inc r13
  jmp beginLoop

  inc r13  ;increment loop counter
  jmp beginLoop
outOfLoop:


pop rax ;push counter at the beginning

;movsd xmm0, xmm14 ; returning sum to caller
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

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**