#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>


int main(int argc, char* argv[]){
    int ret = -1;
    if (argc < 2){
        printf("Usage: %s <shellcode>", argv[0]);
        goto exit;
    }

    int fd = -1;
    if ((fd = open(argv[1], O_RDONLY)) == -1){
        perror("opening shellcode");
        goto exit;
    }
    size_t length;
    if ((length = lseek(fd, 0, SEEK_END)) == -1){
        perror("lseek");
        close(fd);
        goto exit;
    }

    void* mapped_addr = mmap(NULL, length,
            PROT_READ | PROT_WRITE | PROT_EXEC,
            MAP_PRIVATE, fd, 0);

    if (mapped_addr == MAP_FAILED){
        perror("mmap");
        close(fd);
        goto exit;
    }
    close(fd);

    pid_t pid = getpid();
    printf("[+] PID: %d\n\n", pid);
    printf("Mapped at %p\n", mapped_addr);

    int (*start)() = mapped_addr;
    ret = start();

exit:
    return ret;
}
