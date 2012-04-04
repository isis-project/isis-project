#!/bin/bash

LIBPATH=`readlink -f ../staging/lib`

if [ -z "$LD_LIBRARY_PATH" ] ; then
   export LD_LIBRARY_PATH=$LIBPATH
else
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBPATH
fi

START_BS=true

build_usage()
{
   echo options:
   echo "	-b : [true/false] Launches BrowserServer, defaults to true."
   echo "	-d : Launches isis-test in the debugger."
}

while getopts b:d ARG
do
   case "$ARG" in
   b) START_BS=$OPTARG;;
   d) DEBUGGER="gdb --args ";;
   [?]) build_usage
        exit -1;;
   esac
done

export QT_PLUGIN_PATH=`readlink -f ../staging/plugins`
export QTWEBKIT_PLUGIN_PATH=`readlink -f ../staging/lib/BrowserPlugins`

echo $LIBPATH
BSPID=""

if [ "$START_BS" = "true" ] ; then
   echo Killing zombie BrowserServers
   pkill BrowserServer
   echo Starting BrowserServer
   ../staging/bin/BrowserServer &
   BSPID=$!
fi

cd ../isis-test
$DEBUGGER./isis-test -platform xlib

if [ -n "$BSPID" ] ; then
    echo Stopping BrowserServer
    kill $BSPID
fi

