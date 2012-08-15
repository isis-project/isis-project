

## Isis Browser

Open webOS uses a version of QtWebKit to render web pages and applications. Code-named, "Isis-Project", it uses a client-server model that separates the rendering process from the user interface. This architectural approach delivers smooth scrolling and a responsive user experience. The Isis Browser uses the highly portable QT framework with the goal of delivering a cross-platform browser in the future.

# How to Build on Linux

## Dependencies

Below are the tools and libraries (and their minimum versions) required to build the Isis Browser. These build instructions were tested using Ubuntu 10.04 and Ubuntu 11.10 64 bit.

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
* libxinerama-dev
* git-core
* curl
* libgl1-mesa-dev
* libgstreamer0.10-dev
* libgstreamer-plugins-base0.10-dev
* flex
* libicu-dev

- sudo apt-get install g++ cmake libglib2.0-dev gperf  bison  libsqlite3-dev  libssl-dev  libxi-dev  libxrandr-dev  libxfixes-dev  libxcursor-dev  libfreetype6-dev  libxinerama-dev  git-core  curl  libgl1-mesa-dev  libgstreamer0.10-dev  libgstreamer-plugins-base0.10-dev  flex  libicu-dev


To install these packages, use "sudo apt-get install".

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
