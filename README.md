# gyp hello world

[GYP can Generate Your Projects](http://code.google.com/p/gyp/).

It is a pre-build system that uses a json config to generate optimized
project files for various build tools like make, xcode, visual studio.

For example, it is able to generate make or scons files that run fast.

It is also able to generate xcode and visual studio files as if they were
hand created - so cleaner to hand edit or extend.

Its a bit like cmake, except: http://code.google.com/p/gyp/wiki/GypVsCMake

This demo shows how to build a hello world c++ library and command line program
that uses it (called 'mylib'), using gyp to build the files needed by your 
preferred build tool.

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
"myapp" hello world, don't actually need a fancy build system at all
so gyp would likely be overkill.

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
project, gyp can help.


## make

### build

    gyp mylib.gyp --depth=. -f make --generator-output=./projects/makefiles
    make -C ./projects/makefiles/

### test

    $ ./projects/makefiles/out/Default/myapp 
    hello


## scons

### build

    gyp mylib.gyp --depth=. -f scons --generator-output=./projects/sconsfiles
    scons -C projects/sconsfiles/

### test

    $ ./projects/sconsfiles/Default/myapp 
    hello


## xcode

### build

    gyp mylib.gyp --depth=. -f xcode --generator-output=./projects/xcodefiles
    xcodebuild -project ./projects/xcodefiles/mylib.xcodeproj

### test

    # xcode does not respect subdirectory so `build` goes into the main directory
    $ ./build/Default/myapp
    hello

## ninja

Ninja is a build system designed to be ultra fast.

Install it like:

    git clone git://github.com/martine/ninja.git
    cd ninja
    ./bootstrap
    cp ninja /usr/local/bin/

Make sure it works:

    $ ninja
    ninja: no work to do.

Now go back to the hello-gyp project folder and build the sample:

    gyp mylib.gyp --depth=. -f ninja
    ninja -v -C out/Default/ -f build.ninja
    # linking fails on 'ld: unknown option: --threads'
    # so manually link:
    cd out/Default
    g++ -o myapp obj/bin/myapp.myapp.o obj/mylib.a -lz
    cd ../../

### test

    $ ./out/Default/myapp 
    hello


## Others

Other formats are: msvs and ninja as well as some gyp-specific debugging output