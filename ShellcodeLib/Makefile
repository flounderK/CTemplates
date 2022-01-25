CC=gcc
CFLAGS= -fPIC -static -Os -fdata-sections -ffunction-sections -Iinclude -nostdlib --entry=_start -Wl,-Tlinkerscript.ld
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
