# Building The Isis Browser for Linux Desktop

** Note: This is a work in progress. **

## Prerequisites

These build instructions were tested using Ubuntu 10.04 and Ubuntu 11.10 64 bit. The following packages are required:

* g++
* cmake
* libglib2.0-dev
* gperf
* bison
* libsqlite3-dev
* libssl-dev
* libxi-dev
* libxrandr-dev
* libxfixes-dev
* libxcursor-dev
* libfreetype6-dev

To install all these packages:

    $ sudo apt-get install g++ cmake libglib2.0-dev gperf bison libsqlite3-dev libssl-dev libxi-dev libxrandr-dev libxfixes-dev libxcursor-dev libfreetype6-dev libxinerama-dev

## Building Qt 4.8 with QPA

The Isis Browser requires Qt 4.8 built with QPA enabled.  Download Qt 4.8 from ftp://ftp.qt.nokia.com/qt/source/

Note that QTDIR should point to your Source folder where you downloaded qt-everywhere-opensource-src-4.8.0 since this source folder contains some private headers that do not get copied to /usr/local on an install.

Configure Qt as follows:

    $ cd ./qt-everywhere-opensource-src-4.8.0
    $ ./configure -qpa -opensource -no-cups -no-nis -no-exceptions -no-accessibility -no-qt3support -no-xmlpatterns -no-multimedia -no-phonon -no-phonon-backend -no-webkit -confirm-license -make 'libs tools' -opengl desktop
    $ make
    $ pushd src/plugins/platforms/xlib
    $ make
    $ popd
    $ sudo make install
    $ sudo cp plugins/platforms/libqxlib.so /usr/local/Trolltech/QtLighthouse-4.8.0/plugins/platforms/

Make certain that the qmake for Qt 4.8 with QPA is in your path.

## Building the Isis Browser

Check out and run the build scripts from Github. The QTDIR must be set to the location of the Qt 4.8 source code built in the previous step. This enables WebKit  and the QPA plugin to find private Qt header files needed to build.

    $ mkdir isis
    $ cd isis
    $ git clone https://github.com/isis-project/isis-project.git
    $ cd isis-project
    $ ./build.sh 

## Running the Isis Browser

_TBD_

License
-------
This code is released under the Apache 2.0 license.

#### Copyright and License Information

All content, including all source code files and documentation files in this repository are:
Copyright (c) 2012 Hewlett-Packard Development Company, L.P.

All content, including all source code files and documentation files in this repository are:
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this content except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

#### end Copyright and License Information
