#ifndef __DEBUG_UTILS_H__
#define __DEBUG_UTILS_H__
#include <stdio.h>

#if defined(DEBUG)
# define DEBUG_LOG(...) \
    do { \
        printf(__VA_ARGS__); \
    } while (0)
#else
# define DEBUG_LOG(...)
#endif

#endif // __DEBUG_UTILS_H__
