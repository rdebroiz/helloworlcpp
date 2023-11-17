#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xxx::bar" for configuration "Debug"
set_property(TARGET xxx::bar APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(xxx::bar PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/bar.lib"
  )

list(APPEND _cmake_import_check_targets xxx::bar )
list(APPEND _cmake_import_check_files_for_xxx::bar "${_IMPORT_PREFIX}/lib/bar.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
