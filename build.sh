#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
ISIS_PROJECT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $ISIS_PROJECT

. ./scripts/common/envsetup.sh

SRC="
isis-fonts
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
qmlbrowser
"

DEVELOPER=false
PROCCOUNT=$(grep -c processor /proc/cpuinfo)

build_usage()
{
   echo options:
   echo "	-d            : enables developer mode. Code is checked out from github with read and write permissions"
   echo "	-j [Integer]  : Enables multiprocess builds. Similar to make -j command"
   echo "	-t [NAME]     : Builds only named target"
   echo "	-p [NAME/all] : Packages the named target in debian format. all will debianize the isis project."
}

while getopts dj:t:p: ARG
do
   case "$ARG" in
   d) DEVELOPER=true;;
   j) PROCCOUNT=$OPTARG;;
   t) SRC=$OPTARG;;
   p) export PACKAGE=deb
     if [ $OPTARG != "all" ] ; then
         SRC=$OPTARG 
     fi;;
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
      if [ ! -z "$PACKAGE" ]; then
          echo "Package Instructions for $SRC"
          ./build_$CURRENT.sh $CURRENT $PROCCOUNT $PACKAGE
      else
          ./build_$CURRENT.sh $CURRENT $PROCCOUNT
      fi
      #./build_$CURRENT.sh $CURRENT $PROCCOUNT
      [ "$?" == "0" ] || fail "Failed to build: $CURRENT"
   else
      echo No build script for $CURRENT
   fi
done
cd ..
echo ""
echo "============================================"
echo "Isis-Browser build completed"
echo "============================================"
echo ""
