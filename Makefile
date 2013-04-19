
all: mylib


./build/makefiles/Makefile:
	@gyp mylib.gyp --depth=. -f make --generator-output=./build/makefiles

mylib: ./build/makefiles/Makefile
	@make -C ./build/makefiles/

test: mylib
	@./build/makefiles/out/Release/myapp

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