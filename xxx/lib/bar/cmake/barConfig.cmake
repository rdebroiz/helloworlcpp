include(CMakeFindDependencyMacro)
find_dependency(xxx REQUIRED COMPONENTS foo)

include("${CMAKE_CURRENT_LIST_DIR}/barTargets.cmake")