
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include "_syscall.h"
#include "utils.h"


//Make sure to use static const arrays if you use any arrays, otherwise gcc might decide to add a
//call to memcpy

int _start(void)
{
    _write(1, "Hello World\n", 12);

    return 0;
}
