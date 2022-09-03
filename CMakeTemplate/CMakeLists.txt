
cmake_minimum_required(VERSION 3.20)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

message(STATUS "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")
string(TOLOWER ${CMAKE_BUILD_TYPE} LOWER_BUILD_TYPE)
string(FIND "${LOWER_BUILD_TYPE}" "debug" DEBUG_FOUND)
if (NOT ${DEBUG_FOUND} EQUAL -1)
    # Indication to the code that this is a debug build
    add_compile_definitions(DEBUG)
endif()

# link_directories(${CMAKE_SOURCE_DIR}/libs)
project(projectname C)
add_subdirectory(src)

# target_include_directories(projectname PRIVATE ${CMAKE_SOURCE_DIR}/third_party)
