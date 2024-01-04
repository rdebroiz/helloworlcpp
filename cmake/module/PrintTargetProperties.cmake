set(_PROPERTY_LIST
    OUTPUT_NAME
    BINARY_DIR
    COMPILE_DEFINITIONS
    LINK_LIBRARIES
    TYPE
    INCLUDE_DIRECTORIES
    SOURCE_DIR
    SOURCES
)

function(print_target_properties _target)
    if(NOT TARGET ${_target})
      message("There is no target named '${_target}'")
      return()
    endif()

    foreach(_prop ${_PROPERTY_LIST})
        get_target_property(_propval ${_target} ${_prop})
        if (_propval)
            message (STATUS "${_prop}: ${_propval}")
        endif()
    endforeach()
endfunction()
