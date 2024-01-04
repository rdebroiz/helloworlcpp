new_target_library(bar 
    PUBLIC_DEPENDENCIES
        "xxx REQUIRED COMPONENTS foo"
    PUBLIC_LINK_LIBRARIES
        xxx::foo
    SOURCES 
        src/bar.cpp
)
