all: ./build ./build/out/Release/myapp

./deps/gyp:
	git clone --depth 1 https://chromium.googlesource.com/external/gyp.git ./deps/gyp

./build: ./deps/gyp
	deps/gyp/gyp mylib.gyp --depth=. -f make --generator-output=./build

./build/out/Release/myapp: ./build/
	make -C ./build

test: ./build/out/Release/myapp
	./build/out/Release/myapp

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
