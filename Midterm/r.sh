    # ; Juan Uriarte
	# ; uriarte.juan@csu.fullerton.edu
	# ; October 12, 2022
	# ; Section ID: Section 1  
rm *.o
rm *.lis
rm *.out


echo "compile driver.cpp using gcc compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble get_data.asm"
nasm -f elf64 -l get_data.lis -o get_data.o get_data.asm

echo "compile show_data.cpp using gcc compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o show_data.o show_data.cpp

echo "Assemble max.asm."
nasm -f elf64 -l max.lis -o max.o max.asm

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out manager.o get_data.o driver.o show_data.o max.o -std=c++17

echo "Run the Maximum Program:"
./final.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.lis
rm *.out