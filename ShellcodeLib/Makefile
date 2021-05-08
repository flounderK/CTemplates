CC=gcc
CFLAGS= -fPIC -static -Os -fdata-sections -ffunction-sections -nostdlib --entry=_start -Wl,-Tlinkerscript.ld
# export SOURCES:=$(wildcard *.c)
# export OUTPUT+=$(patsubst %.c,%.so,$(SOURCES))

.PHONY: all clean

all: clean shellcode.bin shellcode_head.bin

%.o: %.c
	$(CC) $(CFLAGS) -c $<

shellcode.elf: shellcode.o
	$(CC) $(CFLAGS) -o $@ $^

shellcode.bin: shellcode.elf
	objcopy -j raw_shellcode -O binary $^ $@

shellcode_head.bin: shellcode_head.o
	objcopy -j raw_shellcode -O binary $^ $@

clean:
	rm -f *.so *.o shellcode.elf shellcode_head.elf shellcode_head.bin shellcode.bin 2>/dev/null
