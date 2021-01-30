
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>



extern char __start_inner_shellcode;
extern char __stop_inner_shellcode;

inline long i_syscall(long a, long b, long c, long d)
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

void inner_shellcode(void)
{
    execve("/bin/sh", NULL, NULL);
    //syscall(SYS_execve, "/bin/sh", NULL, NULL);
}


void _start(void)
{
    char* shellcode = &__start_inner_shellcode;
    char* stop_shellcode = &__stop_inner_shellcode;
}
