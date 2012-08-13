.PHONY: install clean

install:
	make install -C qs_assembly
	make install -C qs_c
	make install -C qs_java

clean:
	make clean -C qs_assembly
	make clean -C qs_c
	make clean -C qs_java
