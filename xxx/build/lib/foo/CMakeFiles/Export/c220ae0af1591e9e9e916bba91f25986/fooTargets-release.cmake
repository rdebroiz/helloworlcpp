#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xxx::foo" for configuration "Release"
set_property(TARGET xxx::foo APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(xxx::foo PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/foo.lib"
  )

list(APPEND _cmake_import_check_targets xxx::foo )
list(APPEND _cmake_import_check_files_for_xxx::foo "${_IMPORT_PREFIX}/lib/foo.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
