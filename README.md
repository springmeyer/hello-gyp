# gyp hello world

GYP uses a json config to generate builds project for
various build tools like make, xcode, visual studio.

So its a bit like cmake, except: http://code.google.com/p/gyp/wiki/GypVsCMake

This demo shows how to build a hello world c++ library and command line program
that uses it, using gyp to build the files needed by your preferred build tool.

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