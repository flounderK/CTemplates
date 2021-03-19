
define allow-override
  $(if $(or $(findstring environment,$(origin $(1))),\
            $(findstring command line,$(origin $(1)))),,\
    $(eval $(1) = $(2)))
endef


$(call allow-override,CC,$(CC))
$(call allow-override,LD,$(LD))

CDEBUG=-g
CC?=gcc
CFLAGS=

BINARY=main

.PHONY: all clean


%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<


all: $(BINARY)

$(BINARY): test.o
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(BINARY) *.o *.so 2>/dev/null
