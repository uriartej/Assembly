;****************************************************************************************************************************
;Program name: "Float Numbers".  This program takes in the user input of height and width in float and calculates perimeter *
;and average side length. Copyright (C) 2021 Juan Uriarte.                                                                  *                                                                                                                      *
;This file is part of the software program "Float Number".                                                                  *
;Float Number is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;Float Number is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
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
;  Program name: Rectangle
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2022 Aug 22
;  Date of last update: 2022 Sept 4
;
;  Files in this program: isFloat.cpp, r.sh, driver.cpp
;  Status: Finished.
;
;This file
;   File name: compare.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l compare.lis -o compare.o compare.asm

;===== Begin code area ================================================================================================
extern printf
extern scanf
extern isFloat
extern atof

global compare

segment .data
input_prompt db "Please enter two float numbers separated by white space. Press enter after the second input.", 10, 0
two_string_format db "%s %s", 0
large_num db "The larger number is %.13lf", 10, 10, 0
bad_message db "An invalid input was detected. You may run this program again.", 10, 0
two_float_format db "Your numbers are %.16lf and %.16lf", 10, 0
goodbye db "The assembly will now return execution to the driver module.", 10, 13, "The smaller number will return to the driver. "
segment .bss

segment .text

compare:
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
pushf
                                                       ;Backup rflags                                         
; print input prompt
mov rax, 0
mov rdi, input_prompt
call printf

;take in 2 strings
sub rsp, 2048 ; make space for 2 strings
mov rax, 0
; scanf needs the 2 strings' locations
mov rdi, two_string_format
mov rsi, rsp
mov rdx, rsp
add rdx, 1024
; save the addresses of the string locations on the stack
mov r15, rsp
mov r14, rdx
call scanf


;check if first string is bad input
mov rax, 0
mov rdi, r15
call isFloat
cmp rax, 0
je BadMessage

; validate second float
mov rax, 0
mov rdi, r14
call isFloat
cmp rax, 0
je BadMessage

;is a float, convert to float (first float)
mov rax, 0
mov rdi, r14
call atof
movsd xmm14, xmm0

;is a float, convert to float (second float)
mov rax, 0
mov rdi, r15
call atof
movsd xmm15, xmm0


; print out the 2 nums, this is seg faulting for some reason, figure out if u can
mov rax, 2
mov rdi, two_float_format
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf

;compare the numbers
ucomisd xmm15, xmm14
ja first_num
jmp second_num

;if the first float is greater
first_num:
mov rax, 1
mov rdi, large_num
movsd xmm0, xmm15
call printf
 mov rax, 0
 mov rdi, goodbye
 call printf
 movsd xmm0, xmm14
jmp end

;if the second float is greater
second_num:
mov rax, 1
mov rdi, large_num
movsd xmm0, xmm14
call printf
mov rax, 0
mov rdi, goodbye
call printf
movsd xmm0, xmm15
jmp end


jmp end

BadMessage:
mov rax, 0
mov rdi, bad_message
call printf
mov rax,-1
cvtsi2sd xmm13,rax
movsd xmm0,xmm13
jmp end
;print "bad"
end:
add rsp, 2048


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