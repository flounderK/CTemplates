
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>



static inline long _syscall(long a, long b, long c, long d)
{
    register long rax __asm__ ("rax") = a;
    register long rdi __asm__ ("rdi") = b;
    register long rsi __asm__ ("rsi") = c;
    register long rdx __asm__ ("rdx") = d;
    __asm__ __volatile__(
        "syscall"
        : "+r" (rax)
        : "r" (rdi), "r" (rsi), "r" (rdx)
        : "cc", "rcx", "r11", "memory"
    );
    return rax;
}

// redefine syscalls to avoid libc's wrappers
#define _open(path, flags) _syscall(__NR_open, path, flags, 0)
#define _close(fd) _syscall(__NR_close, fd, 0, 0)
#define _read(fd, buf, nr) _syscall(__NR_read, fd, buf, nr)
#define _write(fd, buf, nr) _syscall(__NR_write, fd, buf, nr)

//Make sure to use static const arrays if you use any arrays, otherwise gcc might decide to add a
//call to memcpy
//

void _start(void)
{

}
