new_target_library(foo 
    PUBLIC_DEPENDENCIES
        "xxx REQUIRED COMPONENTS bar"
    PUBLIC_LINK_LIBRARIES
        xxx::bar
    SOURCES 
        src/foo.cpp
)
