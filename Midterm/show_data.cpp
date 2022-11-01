// ; Juan Uriarte
// ; uriarte.juan@csu.fullerton.edu
// ; October 12, 2022
// ; Section ID: Section 1 

#include <iostream>

extern "C" void Display(double arr[], int arr_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void Display(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.10lf\n", arr[i]);
  }
}