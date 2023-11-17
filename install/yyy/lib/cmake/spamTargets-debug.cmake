#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "yyy::spam" for configuration "Debug"
set_property(TARGET yyy::spam APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(yyy::spam PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/spam.lib"
  )

list(APPEND _cmake_import_check_targets yyy::spam )
list(APPEND _cmake_import_check_files_for_yyy::spam "${_IMPORT_PREFIX}/lib/spam.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
