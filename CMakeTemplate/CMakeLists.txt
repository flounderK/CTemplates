cmake_minimum_required(VERSION 3.13)

if (NOT CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchains/toolchain.x86_64-linux-clang.cmake")
endif()

option(VERBOSE_LOG "Enable debug logging" OFF)

include(cmake/function.print_properties.cmake)
include(cmake/function.dump_cmake_variables.cmake)
include(cmake/function.print_target_properties.cmake)

project(projectname C ASM)
enable_language(C ASM)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_FLAGS_MINSIZEREL "-O2")

include(CheckCCompilerFlag)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Output directories
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

set(COVERAGE_C_FLAGS )

# Compiler options
set(COMMON_C_FLAGS )
list(APPEND COMMON_C_FLAGS "-W")
list(APPEND COMMON_C_FLAGS "-Wall")
list(APPEND COMMON_C_FLAGS "-Wextra")
list(APPEND COMMON_C_FLAGS "-Wno-unused-parameter")
list(APPEND COMMON_C_FLAGS "-Wno-newline-eof")
list(APPEND COMMON_C_FLAGS "-Wno-unused-label")
list(APPEND COMMON_C_FLAGS "-fno-vectorize")
list(APPEND COMMON_C_FLAGS "-fno-slp-vectorize")
list(APPEND COMMON_C_FLAGS "-O2")
# string(REPLACE ";" " " COMMON_C_FLAGS "${COMMON_C_FLAGS}")

if(CMAKE_C_COMPILER_ID MATCHES "Clang")
    set(COMMON_C_FLAGS "${COMMON_C_FLAGS}")
    set(COVERAGE_C_FLAGS "-fprofile-instr-generate -fcoverage-mapping")
elseif(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    set(COMMON_C_FLAGS "${COMMON_C_FLAGS} -Wno-unused-but-set-variable")
    set(COVERAGE_C_FLAGS "-fprofile-arcs -ftest-coverage")
endif()

# Add ASan, coverage, etc.
if(CMAKE_BUILD_TYPE STREQUAL "ASAN")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address -fno-omit-frame-pointer")
endif()
if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COVERAGE_C_FLAGS} --coverage")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --coverage")
endif()

if (${CMAKE_BUILD_TYPE} MATCHES "Debug")
    set(VERBOSE_LOG ON)
    add_compile_definitions(DEBUG)
endif()

if(VERBOSE_LOG)
    message("VERBOSE_LOG is on")
    add_compile_definitions(VERBOSE_LOG)
endif()

# Set global compile flags
add_compile_options(${COMMON_C_FLAGS})

message("CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message("CMAKE_TOOLCHAIN_FILE: ${CMAKE_TOOLCHAIN_FILE}")
message("CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
message("CMAKE_C_COMPILER_ID: ${CMAKE_C_COMPILER_ID}")

include_directories(include)

# src
add_subdirectory(src)

# Tests
# enable_testing()
# add_subdirectory(tests)
