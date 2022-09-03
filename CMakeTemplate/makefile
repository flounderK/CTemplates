
CDEBUG=-g
LD_CFLAGS=-flto=full
SO_CFLAGS=-fPIC $(LD_CFLAGS)
CFLAGS=-fPIC

.PHONY: all clean release debug release_x86_64 debug_x86_64

all: release debug

release: release_x86_64

debug: debug_x86_64

release_x86_64:
	cmake -Bbuild/release-x86_64 -DCMAKE_TOOLCHAIN_FILE=cmake/clang_x86_64.cmake -DCMAKE_BUILD_TYPE=Release
	make -C build/release-x86_64


release_i386:
	cmake -Bbuild/release-i386 -DCMAKE_TOOLCHAIN_FILE=cmake/clang_i386.cmake -DCMAKE_BUILD_TYPE=Release
	make -C build/release-i386


debug_x86_64:
	cmake -Bbuild/debug-x86_64 -DCMAKE_TOOLCHAIN_FILE=cmake/clang_x86_64.cmake -DCMAKE_BUILD_TYPE=Debug
	make -C build/debug-x86_64

debug_i386:
	cmake -Bbuild/debug-i386 -DCMAKE_TOOLCHAIN_FILE=cmake/clang_i386.cmake -DCMAKE_BUILD_TYPE=Debug
	make -C build/debug-i386


clean:
	rm -rf build
