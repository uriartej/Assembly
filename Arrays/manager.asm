;************************************************************************************************************************
;Program name: "Arrays".  This program will allow the user to input numbers in an array of size 6, and display the      *
;contents. It will also add them together and display the result. Copyright (C) 2022 Juan Uriarte.                      *                                                                                         *
;This file is part of the software program "Trianle".                                                                   *
;Array is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License     *
;version 3 as published by the Free Software Foundation.                                                                *
;Array is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied            *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                        *
;************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Juan Uriarte
;  Author email: uriarte.juan@csu.fullerton.edu
;
;Program information
;  Program name: manager.asm
;  Programming languages: One module in C, One module in C++ and three modules in X86
;  Date program began: 2022 Oct 2
;  Date of last update: ??????
;
;  Files in this program: main.cpp, sum.asm, input_array.asm, display_array.cpp, r.sh
;  Status: ??????.
;
;This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern fill
extern Display
extern sum

global manager

segment .data
welcome_control db "Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Juan Uriarte.",10,0
present_numbers db "The numbers you entered are these: ",10,0
the_sum_is db "The sum of these values is %.10lf.", 10 ,0
exit_message db "The control module will now return the sum to the caller module.",10,0

segment .bss  ;Reserved for uninitialized data
the_array resq 6 ; array of 6 quad words reserved before run time.

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

;"Welcome to HSAS. The accuracy and reliability of this program is guaranteed by Johnson Tong."
push qword 0
mov rax, 0
mov rdi, welcome_control
call printf
pop rax

; Fill the array using the fill module
push qword 0
mov rax, 0
mov rdi, the_array ; array passed in as first param
mov rsi, 6         ; array size passed in as second param
call fill
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
; Computing the sum...
push qword 0
mov rax, 0
mov rdi, the_array
mov rsi, 6
call sum ;The sum will be in xmm0
movsd xmm15, xmm0
pop rax

; The sum of these values is ....
push qword 0
mov rax, 1
mov rdi, the_sum_is
movsd xmm0, xmm15
call printf
pop rax

; The sum will be returned to the caller module
push qword 0
mov rax, 0
mov rdi, exit_message
call printf
pop rax

pop rax ; counter push at the beginning

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