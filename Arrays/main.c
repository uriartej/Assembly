#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double manager(void);

int main(int argc, char *argv[])
{
  printf("Welcome to High Speed Array Summation by Juan Uriarte.\n");

  double answer = manager();  // the control module will return the sum of the array contents
  printf("The main has received this number %.10lf and will keep it.\n", answer);
  printf("Thank you for using High Speed Array Software.\n"
          "A zero will be returned to the operating system.\n"
          "Have a good day!\n");
}