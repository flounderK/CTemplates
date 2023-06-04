
define allow-override
  $(if $(or $(findstring environment,$(origin $(1))),\
            $(findstring command line,$(origin $(1)))),,\
    $(eval $(1) = $(2)))
endef

TOOL_PREFIX=
CC=$(TOOL_PREFIX)gcc
LD=$(TOOL_PREFIX)ld

ifdef TOOL_PREFIX
$(call allow-override,CC,$(CC))
$(call allow-override,LD,$(LD))
endif

CDEBUG=-g
CFLAGS=-g -Iinclude -Isrc

BINARY=main

OBJ=build

OBJECTS += src/main.o

OBJECT_FILES=$(addprefix $(OBJ)/, $(OBJECTS))

.PHONY: all clean tests


$(OBJ)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

all: clean $(BINARY)

$(BINARY): $(OBJECT_FILES)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -rf $(OBJ) 2>/dev/null
	find . -type d \( -path include \) -prune -false -o -iname '*.o' -o -iname '*.so' | xargs rm -f
	rm -f $(BINARY) 2>/dev/null
