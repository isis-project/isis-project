#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
ISIS_PROJECT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $ISIS_PROJECT

. ./scripts/common/envsetup.sh

print_usage()
{
   echo options:
   echo "	-t [NAME] : Update only named target"
   echo "	-g [CMD]  : Command to pass to git, defaults to 'pull --all'"
}

GITCMD="pull --all"
SRC="`/bin/ls -1 $ISIS_ROOT`"

while getopts t:g: ARG
do
   case "$ARG" in
   t) SRC=$OPTARG;;
   g) GITCMD=$OPTARG;;
   [?]) print_usage
        exit -1;;
   esac
done

for CURRENT in $SRC ; do
   GITREPO=$ISIS_ROOT/$CURRENT
   if [ -d $GITREPO/.git ] ; then
      echo ===========================
      echo "$CURRENT -> git $GITCMD"
      cd $GITREPO ; git $GITCMD
   fi
done

echo ===========================
echo Done
