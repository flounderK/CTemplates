CC=gcc
CFLAGS= -fPIC -static -Os -fdata-sections -ffunction-sections -Iinclude -nostdlib --entry=_start -Wl,-Tlinkerscript.ld
# export SOURCES:=$(wildcard *.c)
# export OUTPUT+=$(patsubst %.c,%.so,$(SOURCES))

.PHONY: all clean

all: clean shellcode.bin shellcode_runner

shellcode_runner: shellcode_runner.c
	$(CC) -g -o $@ $^

arch/x86_64/_syscall.o: arch/x86_64/_syscall.S
	$(CC) -o $@ -c $^

%.o: %.c
	$(CC) $(CFLAGS) -c $<

shellcode.elf: shellcode.o arch/x86_64/_syscall.o
	$(CC) $(CFLAGS) -o $@ $^

shellcode.bin: shellcode.elf
	objcopy -j raw_shellcode -O binary $^ $@

# shellcode_head.bin: shellcode_head.o
# 	objcopy -j raw_shellcode -O binary $^ $@

clean:
	find . -type f -iname '*.o' | xargs rm -rf 2>/dev/null
	rm -f *.so *.o shellcode.elf shellcode_runner shellcode.bin 2>/dev/null
