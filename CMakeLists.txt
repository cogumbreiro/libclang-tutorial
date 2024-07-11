cmake_minimum_required(VERSION 3.10)

project(hello-world)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin/)

execute_process (
    COMMAND bash -c "clang++ -E -x c++ - -v < /dev/null 2>&1 | grep \"lib/clang\" | awk '{{print $1}}' | grep include"
    OUTPUT_VARIABLE clangBuiltInIncludePath
)

file(
    WRITE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/builtInInclude.path"
    "${clangBuiltInIncludePath}"
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
add_subdirectory(src)


# Specify the location for installed binaries
install(
    TARGETS hello-world
    RUNTIME
    DESTINATION bin
)

install(
    PROGRAMS src/hello-world
    DESTINATION bin
)

# Set CPack configuration
set(CPACK_PACKAGE_NAME hello-world)
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(
    CPACK_DEBIAN_PACKAGE_MAINTAINER
    "Tiago Cogumbreiro <cogumbreiro@users.sf.net>"
)
set(CPACK_PACKAGE_DESCRIPTION "A Hello World example using libclang.")
set(CPACK_PACKAGE_VENDOR "SVL")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

# Include CPack configuration
include(CPack)

