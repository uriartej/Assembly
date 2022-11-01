    // ; Juan Uriarte
	// ; uriarte.juan@csu.fullerton.edu
	// ; October 12, 2022
	// ; Section ID: Section 1 

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double manager(void);

int main(int argc, char *argv[])
{
    printf("Welcome to Maximum authored by Juan Uriarte.");
    double answer = manager();
    printf("Bye.\n");
    printf("A zero was returned to the operating system.\n");
}