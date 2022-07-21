

set(PROJECTNAME_SOURCES projectname.c)


# add_executable(projectname ${PROJECTNAME_SOURCES})
add_library(projectname SHARED ${PROJECTNAME_SOURCES})
target_compile_options(projectname PRIVATE -fPIC)
# target_link_options(projectname PRIVATE -v)

target_link_libraries(projectname PUBLIC dl)
# target_link_libraries(projectname PUBLIC "-static")
# target_link_libraries(projectname PUBLIC stdc++)

add_executable(testprojectname testprojectname.c)
