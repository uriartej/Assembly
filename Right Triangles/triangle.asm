;****************************************************************************************************************************
;Program name: "Triangle".  This program takes in the user input of height and width in float and calculates perimeter and average side length. Copyright (C) 2021 Johnson Tong.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Trianle".                                                                   *
;Triangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Triangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Juan Uriarte
;  Author email: uriarte.juan@csu.fullerton.edu
;
;Program information
;  Program name: Triangle
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2022 Sept 7
;  Date of last update: 2022 Sept 17
;
;  Files in this program: pythagoras.cpp, triangle.asm, r.sh
;  Status: Finished.
;
;This file
;   File name: triangle.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern pythagoras
extern atof
extern stdin
extern strchr
extern fgets

global triangle

segment .data
input_name_prompt db "Please enter your last name: ", 0
name_prompt db "%s", 0
input_title_prompt db "Please enter your title(Mr, Ms, Nurse, Engineer, etc): ", 0
title_prompt db "%s", 0
input_side_triangle db "Please enter the sides of your triangle seperated by ws: ", 10 ,0
two_float db "%lf%lf", 0
length_hypotenuse db "The length of the hypotenuse is %.9lf units", 10, 0
goodbye db "Please enjoy your triangles %s %s.", 10, 0
badMessage db "Wrong value. Numbers have to be postive, please try again.", 10, 0


segment .bss
name resb 30
title resb 30


segment .text

triangle:
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

;=================Calculate Triangle===================================================================================

;print last name prompt
mov rax, 0
mov rdi, input_name_prompt
call printf

;input for last name
mov rax, 0
mov rdi, name
mov rsi, 30
mov rdx,[stdin]
call fgets
;erases memory since we use fgets, this is required when we use fgets
mov rax, 0
mov rdi, name
mov rsi, 10
call strchr
mov byte[rax], 0

;print title prompt
mov rax, 0
mov rdi, input_title_prompt
call printf

;input for title
mov rax, 0
mov rdi, title
mov rsi, 30
mov rdx, [stdin]
call fgets
;erases memory since we use fgets, fgets is a scanner that allows spaces
mov rax, 0
mov rdi, title
mov rsi, 10
call strchr
mov byte[rax], 0

;Invalid Value Message when numbers are not postive, will triger caught
Error:
mov rax, 0
mov rdi, badMessage
call printf

caught:
;input side triangle prompt when numbers are not positive, 
mov rax, 0
mov rdi, input_side_triangle
call printf

;input 2 floats for triangle; both values will be in xmm9 and xmm8
mov rax, 0      ;might be called again if number is negative
mov rdi, two_float
push qword -1
mov rsi, rsp
push qword 999
mov rdx, rsp
call scanf
movsd xmm9, [rsp]      ;xmm9 is one float
pop rax
movsd xmm8, [rsp]      ;xmm8 is other float
pop rax

;---------------------------------
;check for negative inputs
xorpd xmm13, xmm13
ucomisd xmm9, xmm13
jbe Error           ;jbe = jump below will trigger Error if not jump above to postive
ja positive
;output negative message
mov rax, 0
call printf
jmp finish

positive:
xorpd xmm13, xmm13
ucomisd xmm8, xmm13
jbe Error
ja positive2
;output negative message
mov rax, 0
call printf
jmp finish

positive2:

movsd xmm10, xmm9   ;caculate hypotenuse
mulsd xmm9, xmm9
movsd xmm11, xmm8
mulsd xmm8, xmm8
addsd xmm9, xmm8
sqrtsd xmm10, xmm9
;block


mov rax, 1          ;display hypotenuse
mov rdi, length_hypotenuse
movsd xmm0, xmm10
call printf


mov rax, 2
mov rdi, goodbye
mov rsi, title
mov rdx, name
call printf

finish:
movsd xmm0, xmm10

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