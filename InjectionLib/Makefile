CC=gcc
CFLAGS=-shared -fPIC
export SOURCES:=$(wildcard *.c)
export OUTPUT+=$(patsubst %.c,%.so,$(SOURCES))

.PHONY: all clean build

all: clean build

build:
	$(CC) $(CFLAGS) -o $(OUTPUT) $(SOURCES)

clean:
	rm -f $(OUTPUT) 2>/dev/null
