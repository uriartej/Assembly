//****************************************************************************************************************************
//Program name: "display_array".                                                                                             *
// This program will allow a user to input float numbers in an array of size 6, and display the contents. It will also add   *
// them together and display the result.                                                                                     *
// Copyright (C) 2022 Juan Uriarte.                                                                                          *
//                                                                                                                           *
//This file is part of the software program "Array".                                                               *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY// without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Juan Uriarte
//  Author email: uriarte.juan@csu.fullerton.edu
//
//Program information
//  Program name: Array
//  Programming languages: Assembly, C++, C, bash
//  Date program began: 2022 Oct 2
//  Date of last update: ????
//  Date of reorganization of comments: 2022 Oct 2
//  Files in this program: manager.asm, main.c, display_Aarray.cpp, sum.asm, input_array.asm, r.sh
//  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
//
//This file
//   File name: display_array.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o Display_Array.o Display_Array..cc
//   Link: g++ -m64 -no-pie -o final.out manager.o sum.o main.o display_array.o input_array.o -std=c++17
//   Purpose: The control module will call this function "Display_Array" and give it the user defined array and
//            number of elements in that array. Then, the Display function will print out the contents to
//            the terminal.
//========================================================================================================
#include <iostream>

extern "C" void Display(double arr[], int arr_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void Display(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.10lf\n", arr[i]);
  }
}