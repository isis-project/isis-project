# Building The Isis Browser for Linux Desktop

** Note: This is a work in progress. **

## Prerequisites

These build instructions were tested using Ubuntu 10.04 and Ubuntu 11.10 64 bit. The following packages are required: g++, cmake, libglib2.0-dev, gperf, bison, libsqlite3-dev, libssl-dev, libxi-dev, libxrandr-dev, libxfixes-dev, libxcursor-dev, libfreetype6-dev, libxinerama-dev, git-core, curl, libgl1-mesa-dev.

To install these packages:

    sudo apt-get install g++ cmake libglib2.0-dev gperf bison libsqlite3-dev libssl-dev libxi-dev libxrandr-dev libxfixes-dev libxcursor-dev libfreetype6-dev libxinerama-dev git-core curl libgl1-mesa-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libicu-dev

## Building the Isis Browser

Check out and run the build scripts from Github.

    cd $HOME
    mkdir isis
    cd ./isis
    git clone https://github.com/isis-project/isis-project.git
    cd isis-project
    ./build.sh 

## Running the Isis Browser

    cd $HOME/isis/isis-project
    ./run.sh

## Running the Isis Browser and BrowserServer Separately

    cd $HOME/isis/isis-project
    ./run.sh -b false

    # in a separate terminal
    cd $HOME/isis/isis-project
    ./browserserver.sh

License
-------
This code is released under the Apache 2.0 license.

#### Copyright and License Information

All content, including all source code files and documentation files in this repository are:
Copyright &copy; 2012 Hewlett-Packard Development Company, L.P.

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
