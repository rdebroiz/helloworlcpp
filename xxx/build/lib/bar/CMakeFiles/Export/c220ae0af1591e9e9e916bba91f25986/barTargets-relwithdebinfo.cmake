#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xxx::bar" for configuration "RelWithDebInfo"
set_property(TARGET xxx::bar APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(xxx::bar PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/PREIXbar.lib"
  )

list(APPEND _cmake_import_check_targets xxx::bar )
list(APPEND _cmake_import_check_files_for_xxx::bar "${_IMPORT_PREFIX}/lib/PREIXbar.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
