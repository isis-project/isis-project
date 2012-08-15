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
enyo-1.0:enyojs
isis-browser
"

DEVELOPER=false
PROCCOUNT=$(grep -c processor /proc/cpuinfo)
MIRROR=""

build_usage()
{
   echo options:
   echo "	-d            : enables developer mode. Code is checked out from github with read and write permissions"
   echo "	-j [Integer]  : Enables multiprocess builds. Similar to make -j command"
   echo "	-m [mirror]   : Fetch from a mirror for faster builds (example: -m github-mirror.mycompany.com)"
   echo "	-t [NAME]     : Builds only named target"
   echo "	-p [NAME/all] : Packages the named target in debian format. all will debianize the isis project."
}

while getopts dj:t:p:m: ARG
do
   case "$ARG" in
   d) DEVELOPER=true;;
   j) PROCCOUNT=$OPTARG;;
   m) MIRROR=$OPTARG;;
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
   REPO=$(echo $CURRENT | awk -F: '{print $1}')
   USER=$(echo $CURRENT | awk -F: '{print $2}')
   USER=${USER:-isis-project}
   BRANCHARG=""
   BRANCH=$(echo $CURRENT | awk -F: '{print $3}')
   if [ "$BRANCH" != "" ]; then
       BRANCHARG="-b ${BRANCH}"
   fi
   if [ ! -d ../$REPO ] ; then
      if [ "$MIRROR" != "" ]; then
          git clone $BRANCHARG -o mirror git://$MIRROR/$USER/$REPO.git ../$REPO
          pushd ../$REPO
          if [ $DEVELOPER = "true" ] ; then
              git remote add origin git@github.com:$USER/$REPO.git
          else
              git remote add origin https://github.com/$USER/$REPO.git
          fi
          git fetch origin
          branch_name="$(git symbolic-ref HEAD 2>/dev/null)"
          branch_name=${branch_name##refs/heads/}
          git config branch.$branch_name.remote origin
          popd
      else
          if [ $DEVELOPER = "true" ] ; then
              git clone $BRANCHARG git@github.com:$USER/$REPO.git ../$REPO
          else
              git clone $BRANCHARG https://github.com/$USER/$REPO.git ../$REPO
          fi
      fi
      [ "$?" == "0" ] || fail "Failed to checkout: $REPO"
   else
      echo found ../$REPO
   fi
done

cd ./scripts

./build_qt.sh qt $PROCCOUNT
[ "$?" == "0" ] || fail 'Failed to build:qt'

for CURRENT in $SRC ; do
   REPO=`echo $CURRENT | awk -F':' '{print $1}'`
   if [ -x ./build_$REPO.sh ] ; then
      echo building $REPO
      if [ ! -z "$PACKAGE" ]; then
          echo "Package Instructions for $SRC"
          ./build_$REPO.sh $REPO $PROCCOUNT $PACKAGE
      else
          ./build_$REPO.sh $REPO $PROCCOUNT
      fi
      #./build_$REPO.sh $REPO $PROCCOUNT
      [ "$?" == "0" ] || fail "Failed to build: $REPO"
   else
      echo No build script for $REPO
   fi
done
cd ..
echo ""
echo "============================================"
echo "Isis-Browser build completed"
echo "============================================"
echo ""
