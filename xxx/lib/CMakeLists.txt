message(STATUS "Configuring libraries")

option(BUILD_SHARED_LIBS "Build sharded libraries." OFF)

add_subdirectory(foo)
add_subdirectory(bar)