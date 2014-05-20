# gyp hello world

[![Build Status](https://secure.travis-ci.org/springmeyer/hello-gyp.svg)](https://travis-ci.org/springmeyer/hello-gyp)

[![Build status](https://ci.appveyor.com/api/projects/status/9b57lcato29u73uv)](https://ci.appveyor.com/project/springmeyer/hello-gyp)

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

See also:

  - http://n8.io/converting-a-c-library-to-gyp/
  - http://code.google.com/p/gyp/wiki/GypTesting

## Usage

Just grab this sample project and build it:

    git clone git://github.com/springmeyer/hello-gyp.git
    cd hello-gyp
    make

To learn more about how to do this manually, or for different plaforms, read on.

## make

The below commands assume you have gyp installed globally. You can do this like:

    git clone https://chromium.googlesource.com/external/gyp.git
    cd gyp
    sudo python setup.py install

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

    $ ./out/Release/myapp
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
