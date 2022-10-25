hello:
	nasm -felf64 hello.asm -o build/hello.o && ld build/hello.o -o build/hello
	@echo ""
	@build/hello
	@echo ""
triangle:
	nasm -felf64 triangle.asm -o build/triangle.o && ld build/triangle.o -o build/triangle
	@echo ""
	@build/triangle
	@echo ""
clib_main:
	nasm -felf64 clib_main.asm -o build/clib_main.o 
	gcc -fPIC -lc build/clib_main.o -o build/clib_main 
	@echo ""
	@build/clib_main
	@echo ""
pi:
	nasm -felf64 pi.asm -o build/pi.o 
	gcc -fPIC -lc build/pi.o -o build/pi 
	@echo ""
	@build/pi
	@echo ""