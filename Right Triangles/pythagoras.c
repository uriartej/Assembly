#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double triangle(void);

int main(int argc, char *argv[])
{
    
    printf("Welcome to the Right Triangles program maintained by Juan Uriarte.\n"
           "If errors are discovered please report them to Juan Uriarte at uriarte.juan@csu.fullerton.edu for a quick fix.\n"
           "At Columbia Software the customer comes first. ");
    double answer = triangle();
    printf("The main function recieved this number %.4lf and plans to keep it.\n", answer);
    printf("An integer zero will be returned to the operating system. Bye.\n");
    return 0;
} 