
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86)
if (NOT triple)
    message("using default x86_64-linux-gnu target")
    set(triple i386-linux-gnu)
else()
    message("TRIPLE IS ${triple}")
endif()

set(CMAKE_C_COMPILER clang CACHE INTERNAL "C compiler")
set(CMAKE_CXX_COMPILER clang++ CACHE INTERNAL "C++ compiler")
set(CMAKE_AR ar CACHE INTERNAL "ar binary")
set(CMAKE_OBJDUMP objdump CACHE INTERNAL "objdump binary")
set(CMAKE_RANLIB ranlib CACHE INTERNAL "ranlib binary")
set(CMAKE_C_COMPILER_LINKER ld.lld CACHE INTERNAL "ldd binary")
set(CMAKE_C_COMPILER_ID CACHE INTERNAL "Clang")

set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER_TARGET ${triple})
# disable vectorization instructions
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mno-sse -mno-avx -mno-avx2")
# add_link_options("-fuse-ld=lld")

# toolchain paths
# set(CMAKE_SYSROOT ${tools}/sysroot/)
# set(CMAKE_STAGING_PREFIX /home/devel/stage) # where to install things instead of sysroot

# should lookups use host and sysroot? -- see cmake_find_root_path because options here are non-obvious even for cmake
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
