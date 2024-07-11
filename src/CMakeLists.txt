cmake_minimum_required(VERSION 2.9)

find_package(LLVM REQUIRED)
find_package(LibClang REQUIRED)
find_package(Clang REQUIRED)

find_package(PkgConfig)
pkg_check_modules(ZSTD libzstd)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${CLANG_INCLUDE_DIRS})


set(APP_SRC
  Main.cpp
)

# remove trailing whitespaces
string(STRIP ${LLVM_LDFLAGS} LLVM_LDFLAGS)

add_executable(hello-world ${APP_SRC})
target_link_libraries(hello-world
  ${CLANG_LIBS} ${LLVM_LIBS_CORE} ${LLVM_LDFLAGS} ${ZSTD_LDFLAGS})

