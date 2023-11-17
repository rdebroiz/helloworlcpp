set(TARGET_NAME spam)
message(STATUS "Configuring target ${PROJECT_NAME}::${TARGET_NAME}")

add_library(${TARGET_NAME} src/spam.cpp)
add_library(${PROJECT_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})

target_include_directories(
    ${TARGET_NAME} 
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(${TARGET_NAME} PUBLIC xxx::bar)

install(TARGETS ${TARGET_NAME} EXPORT ${TARGET_NAME}Targets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

install(
  DIRECTORY
    include/${PROJECT_NAME}
  DESTINATION
    include
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}ConfigVersion.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

export(
    EXPORT ${TARGET_NAME}Targets 
    FILE ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}Targets.cmake 
    NAMESPACE ${PROJECT_NAME}::
)

configure_file(
  cmake/${TARGET_NAME}Config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}Config.cmake
  COPYONLY
)

install(EXPORT ${TARGET_NAME}Targets
  FILE
  ${TARGET_NAME}Targets.cmake
  NAMESPACE
    ${PROJECT_NAME}::
  DESTINATION
    ${CONFIG_PACKAGE_LOCATION}
)
install(
  FILES
    cmake/${TARGET_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}ConfigVersion.cmake
  DESTINATION
    ${CONFIG_PACKAGE_LOCATION}
)