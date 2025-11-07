clean:
	git clean -dxf
wasi-libc/sysroot:
	cd wasi-libc && make CC=clang
example.wasm: wasi-libc/sysroot
	clang -target wasm32-wasi --sysroot ./wasi-libc/sysroot -nodefaultlibs -I./termbox2 -D_WASI_EMULATED_SIGNAL -lc -lwasi-emulated-signal -o example.wasm example.c
hello.wasm: wasi-libc/sysroot
	clang -target wasm32-wasi --sysroot ./wasi-libc/sysroot -nodefaultlibs -lc -o hello.wasm hello.c
