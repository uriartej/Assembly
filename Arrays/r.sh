#!/bin/bash

#Program: Arrays
#Author: Juan Uriarte

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out


echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c 

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "compile display_array.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cpp

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out manager.o sum.o main.o display_array.o input_array.o -std=c++17

echo "Run the Arrays Program:"
./final.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.lis
rm *.out