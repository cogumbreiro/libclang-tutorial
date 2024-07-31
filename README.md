# Hello world in libclang

A simple project that depends on libclang, following:

https://clang.llvm.org/docs/LibASTMatchersTutorial.html

Tested with: LLVM-15.0 up to LLVM-19.0

# Instructions for macOS

```
$ brew install llvm@15 cmake pkg-config zstd
$ export PATH="$HOMEBREW_PREFIX/opt/llvm@15/bin:$PATH"
$ make
```
