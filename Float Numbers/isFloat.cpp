//Author information
//  Author name: Juan Uriarte
//  Author email: uriarte.juan@csu.fullerton.edu
//  The ifFloat file has already been programmed. Such files are commonly called library functions. The programmer will simplify
//  download isFloat and use it. Don't change the function's documentation. Keep the documentation intact including the names of
//  of other programmers. You may add a simple comment such as "isFloat is used here as part of the Assignment", where Assignment
//  is replaced by the name of your program.
//
//This file
//  Program name: isFloat
//  File name: isFloat.cpp
//  Date development began: 2022-Aug-22
//  Date of last update:  2022-Sept-4
//  Comments reorganized: 2022-Sept-4
//  This is a library function.  It does not belong to any one specific application.  The function is available for inclusion
//  in other applications.  If it is included in another application and there are no modifications made to the executing
//  statements in this file then do not modify the license and do not modify any part of this file; use it as is.
//  Language: C++
//  Max page width: 132 columns
//  Optimal print specification: monospace, 132 columns, 8½x11 paper
//  Testing: This function was tested successfully on a Linux platform derived from Ubuntu.
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o isFloat.o isFloat.cpp -std=c++17
//  Classification: Library
//
//Purpose
//  Scan a contiguous segment of memory from the starting byte to the null character and determine if the string of chars is properly
//  formatted for conversion to a valid float number.  This function, isfloat, does not perform the conversion itself.  That task is
//  is done by a library function such as atof.
//
//Future project
//  Re-write this function in X86 assembly.  
//  Added 2022-Aug-22: This function was re-writen from scratch, that is, without reference to this file.  Feel free to download isfloat.asm
//
//How to call isfloat from an X86 function
//  == Declare isfloat to exist in another file: extern isfloat
//  == Obtain an address pointing to starting byte in memory.  Such an address can be a register like rsp.  Also, the address may
//     be provide by the name of an array.   For example, "mystuff resq 300" declares an array of 300 bytes,  The name "mystuff" may
//     be used as the start of block of memory.
//  == Do the setup block for isfloat:
//     == mov rax,0
//     == mov rdi, <a memory location> such as mov rdi, rsp, or mystuff
//     == call isfloat
//     == The boolean result is returned in rax.  If rax holds exactly 0 then 'false' was returned, otherwise 'true' was returned.

//How to call isFloat from a C function
//  ==Place the prototype near the top of the calling function:  bool isinteger(char []);
//  ==Declare a bool variable:  bool outcome;
//  ==Create an array:  char wonder[200];
//  ==Fill the array with a null-terminate sequence of chars.  Usually this sequence comes from an input device like stdin (keyboard).
//  ==Call the function: outcome = isfloat(wonder)
//  ==Test outcome for true = "It is a float number" or false = "It is not a float number".

//How to call isFloat from a C++ function
//  ==Place the prototype near the top of the calling function:  extern "C" bool isinteger(char []);
//  ==Declare a bool variable:  bool outcome;
//  ==Create an array:  char wonder[200];
//  ==Fill the array with a null-terminate sequence of chars.  Usually this sequence comes from an input device like stdin (keyboard).
//  ==Call the function: outcome = isfloat(wonder)
//  ==Test outcome for true = "It is a float number" or false = "It is not a float number".


#include <iostream>

extern "C" bool isFloat(char [ ]);

bool isFloat(char w[ ])
{   bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint)
               onepoint = true;
         else
               result = result && isdigit(w[k]) ;
         k++;
     }
     return result && onepoint;
}
