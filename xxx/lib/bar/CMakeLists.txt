new_target_library(bar 
	SOURCES 
		src/bar.cpp
	PUBLIC_LINK_LIBRARIES
		xxx::foo
	FIND_DEPENDENCY_ARGS
		"xxx REQUIRED COMPONENTS foo"
)
