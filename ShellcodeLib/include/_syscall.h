#ifndef __SYSCALL_H__
#define __SYSCALL_H__
#include <unistd.h>
#include <sys/syscall.h>
size_t _syscall(size_t number, ...);

#define _open(path, flags) _syscall(__NR_open, path, flags)
#define _close(fd) _syscall(__NR_close, fd)
#define _read(fd, buf, nr) _syscall(__NR_read, fd, buf, nr)
#define _write(fd, buf, nr) _syscall(__NR_write, fd, buf, nr)

#endif
