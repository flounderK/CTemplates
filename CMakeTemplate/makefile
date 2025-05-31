
.PHONY: all clean release debug release_x86_64 debug_x86_64

all: release debug

release: release_x86_64

debug: debug_x86_64

release_x86_64:
	cmake -Bbuild/release-x86_64 --toolchain toolchains/toolchain.x86_64-linux-clang.cmake -DCMAKE_BUILD_TYPE=Release
	cmake --build build/release-x86_64


release_i386:
	cmake -Bbuild/release-i386 --toolchain toolchains/toolchain.i386-linux-clang.cmake -DCMAKE_BUILD_TYPE=Release
	cmake --build build/release-i386

debug_x86_64:
	cmake -Bbuild/debug-x86_64 --toolchain toolchains/toolchain.x86_64-linux-clang.cmake -DCMAKE_BUILD_TYPE=Debug
	cmake --build build/debug-x86_64

debug_i386:
	cmake -Bbuild/debug-i386 --toolchain toolchains/toolchain.i386-linux-clang.cmake -DCMAKE_BUILD_TYPE=Debug
	cmake --build build/debug-i386


clean:
	rm -rf build
