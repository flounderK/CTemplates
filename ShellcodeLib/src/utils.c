
#include <unistd.h>
#include "_syscall.h"

void print_hex_size_t(size_t val){
    long long i;
    unsigned char hex[] = { 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
                     0x37, 0x38, 0x39,
                     0x61, 0x62, 0x63, 0x64, 0x65, 0x66,
                     0x0};

    for (i = ((sizeof(val)*8)-8); i >= 0; i = i - 8){
        _write(1, &hex[((val >> (i+4)) & 0xful)], 1);
        //_write(1, "\n", 1);
        _write(1, &hex[((val >> i) & 0xful)], 1);
        //_write(1, "\n", 1);
        //_write(1, "\n", 1);
    }
    _write(1, "\n", 1);
}
