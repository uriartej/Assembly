# # // Juan Uriarte
# // CPSC240-1
# // Final Program Test
# // uriarte.juan@csu.fullerton.edu


rm *.o
rm *.lis
rm *.out

#echo "compile driver.cpp using the g++ compiler standard 2017"
g++ -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.cpp -std=c++17

g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17

#echo "Assemble compare.asm"
nasm -f elf64 -l supervisor.lis -o supervisor.o supervisor.asm

nasm -f elf64 -l fillarray.lis -o fillarray.o fillarray.asm

nasm -f elf64 -l hsum.lis -o hsum.o hsum.asm

#echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -fno-pie -no-pie -o final.out driver.o supervisor.o fillarray.o display_array.o hsum.o -std=c++17

#echo "Run the driver Program:"
./final.out

#echo "Script file has terminated."

rm *.o
rm *.lis
rm *.out
