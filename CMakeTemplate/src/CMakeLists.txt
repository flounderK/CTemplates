

set(PROJECTNAME_SOURCES projectname.c)


add_library(projectname SHARED ${PROJECTNAME_SOURCES})
target_compile_options(projectname PRIVATE -fPIC)

target_link_libraries(projectname dl)

add_executable(testprojectname testprojectname.c)
