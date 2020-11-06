
// Run with LD_PRELOAD='./inject.so' ./binary
// gcc -shared -fPIC -o inject.so inject.c
//


long ptrace(int a, int b, void *c, void *d){
    return 0;
}
