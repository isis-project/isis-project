#!/bin/bash

ISIS_PROJECT=$(cd `dirname $0` && pwd)
. $ISIS_PROJECT/scripts/common/envsetup.sh

SRC="
npapi-headers
pbnjson
AdapterBase
WebKit
WebKitSupplemental
BrowserServer
BrowserAdapter
enyo-1.0
isis-browser
isis-test
"

DEVELOPER=false
PROCCOUNT=$(grep -c processor /proc/cpuinfo)

build_usage()
{
   echo options:
   echo "	-d : enables developer mode. Code is checked out from github with read and write permissions"
   echo "	-j [Integer] : Enables multiprocess builds. Similar to make -j command"
   echo "	-t [NAME] : Builds only named target"
}

while getopts dj:t: ARG
do
   case "$ARG" in
   d) DEVELOPER=true;;
   j) PROCCOUNT=$OPTARG;;
   t) SRC=$OPTARG;;
   [?]) build_usage
        exit -1;;
   esac
done

get_qt

for CURRENT in $SRC ; do
   if [ ! -d ../$CURRENT ] ; then
      if [ $DEVELOPER = "true" ] ; then
         git clone git@github.com:isis-project/$CURRENT.git ../$CURRENT
      else
         git clone https://github.com/isis-project/$CURRENT.git ../$CURRENT
      fi
      [ "$?" == "0" ] || fail "Failed to checkout: $CURRENT"
   else
      echo found ../$CURRENT
   fi
done

cd ./scripts

./build_qt.sh qt $PROCCOUNT
[ "$?" == "0" ] || fail 'Failed to build:qt'

for CURRENT in $SRC ; do
   if [ -x ./build_$CURRENT.sh ] ; then
      echo building $CURRENT
      ./build_$CURRENT.sh $CURRENT $PROCCOUNT
      [ "$?" == "0" ] || fail "Failed to build: $CURRENT"
   else
      echo No build script for $CURRENT
   fi
done
cd ..
echo "Build completed :)"
