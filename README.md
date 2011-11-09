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

## make

### build

    gyp mylib.gyp --depth=. -f make --generator-output=./projects/makefiles
    make -C ./projects/makefiles/

### test

    ./projects/makefiles/out/Default/myapp 
    hello


## scons

### build

    gyp mylib.gyp --depth=. -f scons --generator-output=./projects/sconsfiles
    scons -C projects/sconsfiles/

### test

    ./projects/sconsfiles/Default/myapp 
    hello


## xcode

### build

    gyp mylib.gyp --depth=. -f xcode --generator-output=./projects/xcodefiles
    xcodebuild -project ./projects/xcodefiles/mylib.xcodeproj

### test

    # xcode does not respect subdirectory so `build` goes into the main directory
    ./build/Default/myapp
    hello
    

## Others

Other formats are: msvs and ninja as well as some gyp-specific debugging output