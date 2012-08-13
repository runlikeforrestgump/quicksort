.PHONY: install clean

qs_assembly: qs_assembly.o
	ld qs_assembly.o -o qs_assembly -lc -I/lib/ld-linux.so.2

qs_assembly.o: quicksort.asm
	as quicksort.asm -o qs_assembly.o -g

install: qs_assembly

clean:
	rm qs_assembly.o qs_assembly
