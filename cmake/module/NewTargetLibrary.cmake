#[=[
Create a new target for a library.

---

Synopsis:

    new_target_library(<target> SOURCES <sources>...
        [
            NAMESPACE <namespace> 
            VERSION <version> 
            PUBLIC_DEPENDENCIES <public_dependencies>...
            PRIVATE_DEPENDENCIES <private_dependencies>...
            PUBLIC_LINK_LIBRARIES <public_link_libraries>...
            PRIVATE_LINK_LIBRARIES <private_link_libraries>...
            LIBRARY_OUTPUT_NAME_PREFIX <library_output_name_prefix>
        ]
    )

---
    
    The target's underlying sources and include directories tree is expected to respect a predifined structure.
All sources are expected to be found in an `src` folder along the CMakeLists.txt file containing the call to this function.
All public headers are expected to be found in a `include/namespace/target` folder along the CMakeLists.txt file 
containing the call to this function. Private headers are expected to be found along the sources.

Public headers are then included using their path relative to the `include` folder .
Private headers are included using their path relative to the `srcs` folder.

Example, using the following tree:

    ├───CMakeLists.txt
    │
    ├───include
    │   └───namsepace
    │       └───target
    │           └───my_public_header.h
    │
    └───src
        ├──target.cpp
        └───private
            └───my_private_header.h

    the file `my_public_header.h` would be inclded using: 
        `#include <namespace/target/my_public_header.h>`
    and the file `my_private_header.h` would be included using:  
        `#include <private/my_private_header.h>`

    A public export file is generated in the build tree and is expected to be included with: `#include <namespace/target/export.h>`
It exposes the macro: `<NAMESPACE>_<TARGET>_EXPORT` where <NAMSEPACE> is the uppercase of the <namspace> parameter and <target> the 
uppercase of the <target> parameter.

    The created target will be then refered in the cmake environment as `namespace::target` while the lib object is created as `namspace_target.[lib/dll/so/a...]`.
for example to link later to the newly created Bar target delacared in the Foo namespace, one would do:
    
    `target_link_libraries(my_target PUBLIC Foo::Bar)`

while the created object would be named `Foo_Bar.[lib/dll/so/a...]`
The prefix added in front of the target name for the library name can be controlled with the <library_output_name_prefix> parameter.
For example with <library_output_name_prefix> set to `F`, the output library name would be `FBar.[lib/dll/so/a...]`

How dpendencies required by the target are specfied with PUBLIC_DEPENDENCIES and PRIVATE_DEPENDENCIES. It is a list of parameter to pass to the 
`find_package` and `find_dependency` commands. PUBLIC_DEPENDENCIES are added to the `find_package` (call during the invocation of this function)
and `find_dependency` (call during the invocation of the generated ${_target}Config.cmake module). PRIVATE_DEPENDENCIES are only added to the `find_package` command.

Example: 

the command to create a new lib target called MyLib requiring a public dependence to the libs: Qt6::Widgets, Qt6::Graphics and boost::graph could look like:

    ```
    new_target_library(MyLib 
        SOURCES 
            src/mylib.cpp
        PUBLIC_LINK_LIBRARIES
            Qt6::Widgets
            Qt6::Graphics
            boost::graph
        PUBLIC_DEPENDENCIES
            "Qt6 REQUIRED COMPONENTS Widgets Graphics"
            "Boost REQUIRED COMPONENTS graph"
    )
    ```

    /!\ Note the double quote surrouding each set of parameters of the find_dependency command passed to PUBLIC_DEPENDENCIES.

---

Parameters:
    <target>:                       - Name of the target to create.
    <sources>:                      - List of file to compile

Optional Parameters
    <namespace>:                    - Name of the namespace the target lives in. (default ${PROJECT_NAME})
    <version>:                      - Version of the craeted target. Used in <target>ConfigVersion.cmake file. (default ${PROJECT_VERSION})
    <public_link_libraries>         - List of library to publicly link with
    <private_link_libraries>        - List of library to privately link with
    <public_dependencies>           - A list of args to pass to the `find_package` and `find_dependency` command in the <target>Config.cmake file
    <private_dependencies>           - A list of args to pass to the `find_package` command
    <library_output_name_prefix>    - The prefix to add in front of the library output name. (default <namespace>_)

#]=]

function(new_target_library _target)
    
    ############################################################################
    ############################################################################
    
    set(_options "")
    set(_one_value_args 
        TARGET 
        NAMESPACE 
        VERSION 
        LIBRARY_OUTPUT_NAME_PREFIX
    )
    set(_multi_value_args 
        SOURCES 
        PUBLIC_LINK_LIBRARIES 
        PRIVATE_LINK_LIBRARIES 
        PUBLIC_DEPENDENCIES
        PRIVATE_DEPENDENCIES
    )

    cmake_parse_arguments("" "${_options}" "${_one_value_args}" "${_multi_value_args}" ${ARGN})

    ############################################################################
    ############################################################################

    # Check TARGET_NAME argument
    if(NOT DEFINED _target)
        message(FATAL_ERROR "Call to 'new_target_library' without any target name")
    endif()

    # Check _SOURCES argument
    if(NOT DEFINED _SOURCES OR DEFINED _SOURCES_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "Call to 'new_target_library' for ${_target} without any SOURCES")
    endif()

    # Check NAMESPACE argument
    if(NOT DEFINED _NAMESPACE)
        if(DEFINED _NAMESPACE_KEYWORDS_MISSING_VALUES)
            message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified NAMESPACE parameter")
        endif()
        set(_NAMESPACE ${PROJECT_NAME})
    endif()

    string(TOUPPER ${_NAMESPACE} _NAMESPACE_UPPER)

    # Check VERSION argument
    if(NOT DEFINED _VERSION)
        if(DEFINED _VERSION_KEYWORDS_MISSING_VALUES)
            message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified VERSION parameter")
        endif()
        set(_VERSION ${PROJECT_VERSION})
    endif()

    # Check PUBLIC_LINK_LIBRARIES argument
    if(DEFINED _PUBLIC_LINK_LIBRARIES_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified PUBLIC_LINK_LIBRARIES parameter")
    endif()

    # Check PRIVATE_LINK_LIBRARIES argument
    if(DEFINED _PRIVATE_LINK_LIBRARIES_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified PRIVATE_LINK_LIBRARIES parameter")
    endif()

    # Check PUBLIC_DEPENDENCIES argument
    if(DEFINED _PUBLIC_DEPENDENCIES_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified PUBLIC_DEPENDENCIES parameter")
    endif()

    # Check PRIVATE_DEPENDENCIES argument
    if(DEFINED _PRIVATE_DEPENDENCIES_KEYWORDS_MISSING_VALUES)
        message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified PRIVATE_DEPENDENCIES parameter")
    endif()

    # Check LIBRARY_OUTPUT_NAME_PREFIX argument
    if(NOT DEFINED _LIBRARY_OUTPUT_NAME_PREFIX)
        if(DEFINED _LIBRARY_OUTPUT_NAME_PREFIX)
            message(FATAL_ERROR "Call to 'new_target_library' for ${_target} has no value for specified LIBRARY_OUTPUT_NAME_PREFIX parameter")
        endif()
        set(_LIBRARY_OUTPUT_NAME_PREFIX ${_NAMESPACE}_)
    endif()
    
    
    ############################################################################
    ############################################################################

    # include required modules
    include(GenerateExportHeader)
    include(CMakePackageConfigHelpers)

    ############################################################################
    ############################################################################

    message(STATUS "Configuring target ${_NAMESPACE}::${_target}")

    # find packages for public and private dependencies
    if(DEFINED _PUBLIC_DEPENDENCIES)
        message(STATUS "looking for public dependencies package")
        foreach(_find_package_args ${_PUBLIC_DEPENDENCIES})
            separate_arguments(_find_package_args)
            find_package(${_find_package_args})
        endforeach()
    endif()
    if(DEFINED _PRIVATE_DEPENDENCIES)
        message(STATUS "looking for private dependencies package")
        foreach(_find_package_args ${_PRIVATE_DEPENDENCIES})
            separate_arguments(_find_package_args)
            find_package(${_find_package_args})
        endforeach()
    endif()

    # Add library
    add_library(${_target} ${_SOURCES})
    # Add a library alias
    add_library(${_NAMESPACE}::${_target} ALIAS ${_target})
    # Set the library output name
    set_property(TARGET ${_target} PROPERTY OUTPUT_NAME "${_LIBRARY_OUTPUT_NAME_PREFIX}${_target}")


    # Set link flags
    if(DEFINED _PUBLIC_LINK_LIBRARIES)
        target_link_libraries(${_target} PUBLIC ${_PUBLIC_LINK_LIBRARIES})
    endif()
    if(DEFINED _PRIVATE_LINK_LIBRARIES)
        target_link_libraries(${_target} PRIVATE ${_PRIVATE_LINK_LIBRARIES})
    endif()
    

    # Generate export header
    set(_TARGET_EXPORT_FILENAME include/${_NAMESPACE}/${_target}/export.h)

    generate_export_header(${_target} 
    EXPORT_FILE_NAME 
        ${_TARGET_EXPORT_FILENAME} 
    PREFIX_NAME 
        ${_NAMESPACE_UPPER}_
    )
    # Set include flags
    target_include_directories(
        ${_target} 
        PUBLIC 
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
            $<INSTALL_INTERFACE:include>
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/src
    )

    
    # Generate ${_TARGET}ConfigVersion.cmake in build tree
    write_basic_package_version_file(
        ${CMAKE_BINARY_DIR}/cmake/${_target}ConfigVersion.cmake
        VERSION ${_VERSION}
        COMPATIBILITY AnyNewerVersion
    )

    # Reconstruct the find_dependency string to evaluate in ${_target}Config.cmake
    if(DEFINED _PUBLIC_DEPENDENCIES)
        set(_FIND_DEPENDENCY_CMD "include(CMakeFindDependencyMacro)")
        foreach(_args ${_PUBLIC_DEPENDENCIES})
            string(PREPEND _args "find_dependency(")
            string(APPEND _args ")")
            list(APPEND _FIND_DEPENDENCY_CMD ${_args})
        endforeach()
        string(JOIN "\n" _FIND_DEPENDENCY_CMD ${_FIND_DEPENDENCY_CMD})
    endif()
    # Generate ${_target}Config.cmake in build tree
    configure_file(
        ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/configure/TargetLibraryConfig.cmake.in
        ${CMAKE_BINARY_DIR}/cmake/${_target}Config.cmake
        @ONLY
    )

    
    # Install target. define an EXPORT name (${_target}Target)
    # and define artifacts destinations.
    install(TARGETS ${_target} EXPORT ${_target}Target
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include
    )

    # Install public headers from source tree
    install(
      DIRECTORY
        include/${_NAMESPACE}
      DESTINATION
        include
    )

    # Install public headers from binary tree
    # typically export headers.
    install(
      DIRECTORY
        ${CMAKE_CURRENT_BINARY_DIR}/include/${_NAMESPACE}
      DESTINATION
        include
    )

    # Install the Target definition file (${_target}Target.cmake)
    install(EXPORT ${_target}Target
      FILE
      ${_target}Target.cmake
      NAMESPACE
        ${PROJECT_NAME}::
      DESTINATION
        lib/cmake/${_NAMESPACE}
    )

    # Install the Config files (${_target}Config.cmake and ${_target}ConfigVersion.cmake)
    install(
      FILES
        ${CMAKE_BINARY_DIR}/cmake/${_target}Config.cmake
        ${CMAKE_BINARY_DIR}/cmake/${_target}ConfigVersion.cmake
      DESTINATION
        lib/cmake/${_NAMESPACE}
    )


    # Export the target in the build tree so it can be reused as ${_NAMESPACE}::${_TARGET_NAME} 
    # later in the current CMake project the same way the installed one would be used.
    export(
        EXPORT ${_target}Target
        FILE ${CMAKE_BINARY_DIR}/cmake/${_target}Target.cmake 
        NAMESPACE ${_NAMESPACE}::
    )

endfunction()