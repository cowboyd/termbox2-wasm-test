## termbox2 wasm

This repo is an attept to compile the termbox2 demo using WASM + WASI

### Install

You'll need `clang`, and `wasmtime`

This uses termbox2 and wasi-libc, so pull in these git modules

```
git submodule update --init
```

Also, to use wasix, you'll need to install the wasm compiler rt library compiled (https://github.com/jedisct1/libclang_rt.builtins-wasm32.a) or build it yourself.

### Build example

This is a smoke test to make sure that the wasm toolchain is setup properly.

```
make hello.wasm
```

Now you should able to run it with `wasmtime` or `wasmer`

```
$ wasmtime hello.wasm
Hello World
```

### Build termbox2 example

This just attempts to build the example from the README:

with __wasix__ (wasmer only)

```
$ make example.wasix
```

which you can then run with `wasmer`

```
$ wasmer run example.wasix.wasm
```

with __wasi__ (not currently working)

```
$ make example.wasi
clang -target wasm32-wasi --sysroot ./wasi-libc/sysroot -nodefaultlibs -I./termbox2 -D_WASI_EMULATED_SIGNAL -lc -lwasi-emulated-signal -o example.wasm example.c
In file included from example.c:2:
./termbox2/termbox2.h:51:10: fatal error: 'termios.h' file not found
   51 | #include <termios.h>
      |          ^~~~~~~~~~~
1 error generated.
make: *** [example.wasm] Error 1
```



