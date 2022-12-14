// ; // Juan Uriarte
// ; // CPSC240-1
// ; // Final Program Test
// ; // uriarte.juan@csu.fullerton.edu

#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;

extern "C" double supervisor();

int main(int argc, char *argv[])
{
    cout << "Welcome to Harmonic Mean by Juan Uriarte." << endl;
    cout << "This program will compute the harmonic mean of your numbers." << endl;

    double myNum;
    myNum = supervisor();

    cout << endl;
    cout << "The bench mark time will be returned to the driver." << endl;
    cout << "The main program received " << myNum << endl;
    cout << endl;
    cout << "The time on the wall is now "; 

    cout << endl;
    cout << "Have a great rest of your day.  Zero will be sent to the OS." << endl;
}