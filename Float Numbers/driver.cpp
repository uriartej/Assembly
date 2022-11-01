#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <iostream>

extern "C" double compare();

int main(int argc, char *argv[])
{
    printf("Welcome to Floating Points Numbers programmed by Juan Uriarte.\n"
           "Mr Uriarte has been working for the Longstreet Software Company for the last two years.\n");
    double answer = compare();
    printf("The driver module received this float number %lf and will keep it.\n", answer);
    printf("The driver module will return integer 0 to the operating system.\n");
    printf("Have a nice day. Good-bye.\n");
    return 0;
}
