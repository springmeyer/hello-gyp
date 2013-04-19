# gyp hello world

[GYP can Generate Your Projects](http://code.google.com/p/gyp/).

It is a pre-build system that uses a json config to generate optimized
project files for various build tools like make, xcode, visual studio.

For example, it is able to generate make or scons files that run fast.

It is also able to generate xcode and visual studio files.

It's a bit like cmake, except: http://code.google.com/p/gyp/wiki/GypVsCMake

This demo shows how to build:

 - a hello world c++ library (called 'mylib')
 - a command line program that uses/links to it
 - a node.js module that depends on mylib via it gyp file

See also: http://code.google.com/p/gyp/wiki/GypTesting

## Setup

First install gyp if you do not have it already. It's just python:

    svn checkout http://gyp.googlecode.com/svn/trunk/ gyp
    cd gyp
    sudo python setup.py install
    
Now you should have the `gyp` program on your `PATH`:

    $ which gyp
    /usr/local/bin/gyp

Now grab this sample project:

    git clone git://github.com/springmeyer/hello-gyp.git
    cd hello-gyp


## no build system

First, it's important to remember that simple codebases, like this
"myapp" hello world, don't actually need a fancy build system.

You can build the library and program "by hand" like:

    mkdir manual-build

    # build static library
    g++ -static -I./include -c ./src/implementation.cc -o manual-build/mylib.o
    ar rcsT manual-build/libmylib.a manual-build/mylib.o

    # build program and link the library
    g++ -o manual-build/myapp  -I./include bin/myapp.cc -L./manual-build -lmylib

### test

    $ ./manual-build/myapp
    hello

But, as your projects grow, or you wish to have other projects build against this
project, gyp can help immensely.


## make

### build

    gyp mylib.gyp --depth=. -f make --generator-output=./build/makefiles
    V=1 make -C ./build/makefiles/

### test

    $ ./build/makefiles/out/Release/myapp
    hello

And the node module:

    npm install node-gyp
    node_modules/.bin/node-gyp configure build

Test the node module:

    $ node -e "console.log(require('./build/Release/modulename.node').hello())"
    hello

## scons

### build

    gyp mylib.gyp --depth=. -f scons --generator-output=./build/sconsfiles
    scons -C ./build/sconsfiles/

### test

    $ ./build/sconsfiles/Release/myapp
    hello


## xcode

### build

    gyp mylib.gyp --depth=. -f xcode --generator-output=./build/xcodefiles
    xcodebuild -project ./build/xcodefiles/mylib.xcodeproj

### test

    # xcode does not respect subdirectory so `build` goes into the main directory
    $ ./build/Release/myapp
    hello

## ninja

Ninja is a build system designed to be ultra fast.

Install it like:

    git clone git://github.com/martine/ninja.git
    cd ninja
    ./bootstrap.py
    cp ninja /usr/local/bin/

Make sure it works:

    $ ninja
    ninja: no work to do.

Now go back to the hello-gyp project folder and build the sample:

    gyp mylib.gyp --depth=. -f ninja
    ninja -v -C out/Release/ -f build.ninja

### test

    $ ./out/Relase/myapp
    hello

## Microsft Visual Studio C++ 2010 Expres

Note, this assumes you've downloaded and installed the free 2010 C++ studio.

    python gyp/gyp mylib.gyp --depth=. -f msvs -G msvs_version=2010
    msbuild mylib.sln

### test

    c:\hello-gyp>Release\myapp.exe
    hello


## Others

Other formats are some some gyp-specific debugging output