.PHONY: install clean

qs_c: qs_c.o
	gcc qs_c.o -o qs_c

qs_c.o: quicksort.c
	gcc -c quicksort.c -o qs_c.o 

install: qs_c

clean:
	rm qs_c.o qs_c
