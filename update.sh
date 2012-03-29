#!/bin/bash

. ./scripts/common/envsetup.sh

build_usage()
{
   echo options:
   echo "	-t [NAME] : Update only named target"
   echo "	-g [CMD]  : Command to pass to git, defaults to 'pull'"
}

GITCMD=pull
SRC="`/bin/ls -1 $ISIS_ROOT`"

while getopts t:g: ARG
do
   case "$ARG" in
   t) SRC=$OPTARG;;
   g) GITCMD=$OPTARG;;
   [?]) build_usage
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

cd $STARTDIR

