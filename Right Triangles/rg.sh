#!/bin/bash

#Program: r.sh
#Author: Juan Uriarte

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "compile pythagoras.cpp using the g++ compiler standard 2017"
gcc -c -Wall -no-pie -m64 -std=c17 -o pythagoras.o pythagoras.c -g

echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm -gdwarf

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out triangle.o pythagoras.o -std=c17 -g

echo "Run the Right Triangle Program:"
gdb ./final.out 

echo "Script file has terminated."

rm *.o
rm *.lis
rm *.out