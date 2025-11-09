clean:
	git clean -dxf
wasi-libc/sysroot:
	cd wasi-libc && make CC=clang
hello.wasi: wasi-libc/sysroot
	clang -target wasm32-wasi --sysroot ./wasi-libc/sysroot -nodefaultlibs -lc -o hello.wasm hello.c
example.wasi: wasi-libc/sysroot
	clang -target wasm32-wasi --sysroot ./wasi-libc/sysroot -nodefaultlibs -I./termbox2 -D_WASI_EMULATED_SIGNAL -lc -lwasi-emulated-signal -o example.wasi.wasm example.c
example.wasix:
	clang -target wasm32-wasi --sysroot ./wasix-sysroot/sysroot  -I./termbox2 -lc -o example.wasix.wasm example.c
example.native:
	clang example.c -o example.native

