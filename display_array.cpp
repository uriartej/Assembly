// Juan Uriarte
// CPSC240-1
// Final Program Test
// uriarte.juan@csu.fullerton.edu

#include<stdio.h>

extern "C" void printArray(float array[], long amount);

void printArray(float array[], long amount){
	
	printf("\n");

	printf("Here are 10 numbers of the array at the beginning.\n");
	for (int i = 0; i < amount ; ++i){
		printf("%1.9f\n", array[i]);
	}
}
	