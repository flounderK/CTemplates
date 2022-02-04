CC=clang
BFD_LFLAGS=-Wl,-Tlinkerscript.ld
# specifying lto level here allows the usage of size optimization
# (-Os) and full link time optimization (-flto=full) in CFLAGS
# These options together make a smaller bin and also
# actually removing unnecessary rel/rela entries like ld.bfd does by default
LLD_LFLAGS=-Wl,-Tlinkerscript.ld,--pie,--gc-sections,--lto-O3
# LFLAGS=-Wl,-Tlinkerscript.ld,--pie,--gc-sections,--no-check-sections
LLD_CFLAGS=-fuse-ld=lld -flto=full
BFD_CFLAGS=
COMMON_CFLAGS=-fPIC -static -Os \
		-fdata-sections \
		-ffunction-sections \
		-Iinclude \
		-nostdlib

# CFLAGS= $(BFD_CFLAGS) $(COMMON_CFLAGS) $(BFD_LFLAGS)
CFLAGS= $(LLD_CFLAGS) $(COMMON_CFLAGS) $(LLD_LFLAGS)

# export SOURCES:=$(wildcard *.c)
# export OUTPUT+=$(patsubst %.c,%.so,$(SOURCES))

.PHONY: all clean

all: clean shellcode.bin shellcode_runner

shellcode_runner: shellcode_runner.c
	$(CC) -g -o $@ $^

obj/src/arch/x86_64/_syscall.o: src/arch/x86_64/_syscall.S
	mkdir -p obj/src/arch/x86_64/
	$(CC) -o $@ -c $^

obj/src/%.o: src/%.c
	mkdir -p obj/src
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.c
	$(CC) $(CFLAGS) -c $<

obj/shellcode.elf: obj/src/shellcode.o obj/src/arch/x86_64/_syscall.o obj/src/utils.o
	$(CC) $(CFLAGS) -o $@ $^

shellcode.bin: obj/shellcode.elf
	objcopy -j raw_shellcode -O binary $^ $@

clean:
	find . -type f -iname '*.o' | xargs rm -rf 2>/dev/null
	rm -rf obj *.so *.o shellcode.elf shellcode_runner shellcode.bin 2>/dev/null
