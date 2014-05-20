all: ./build ./build/out/Release/myapp

./deps/gyp:
	git clone --depth 1 https://chromium.googlesource.com/external/gyp.git ./deps/gyp

./build: ./deps/gyp
	deps/gyp/gyp mylib.gyp --depth=. -f make --generator-output=./build

./build/out/Release/myapp: ./build/
	make -C ./build V=1

test: ./build/out/Release/myapp
	./build/out/Release/myapp

no-gyp-libstdcpp:
	mkdir -p out
	rm -f out/implementation.o
	c++ -Iinclude -O3 -DNDEBUG -c -o out/implementation.o src/implementation.cc
	rm -f out/libmylib.dylib
	c++ -dynamiclib -o out/libmylib.dylib out/implementation.o

no-gyp-libcpp:
	mkdir -p out
	rm -f out/implementation.o
	c++ -Iinclude -std=c++11 -stdlib=libc++ -O3 -DNDEBUG -c -o out/implementation.o src/implementation.cc
	rm -f out/libmylib.dylib
	c++ -dynamiclib -stdlib=libc++ -o out/libmylib.dylib out/implementation.o

./node_modules/.bin/node-gyp:
	npm install node-gyp

node: node_modules/.bin/node-gyp
	node_modules/.bin/node-gyp configure build
	node -e "console.log(require('./build/Release/modulename.node').hello())"

clean:
	rm -rf ./build
	rm -rf ./node_modules
	rm -rf ./out
	rm -rf ./node-addon/build


.PHONY: test
