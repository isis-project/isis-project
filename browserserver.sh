#!/bin/bash

LIBPATH=`readlink -f ../staging/lib`

if [ -z "$LD_LIBRARY_PATH" ] ; then
   export LD_LIBRARY_PATH=$LIBPATH
else
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBPATH
fi

export QT_PLUGIN_PATH=`readlink -f ../staging/plugins`

echo $LIBPATH

build_usage()
{
   echo options:
   echo "	-d : Launches BrowserServer in the debugger."
}

while getopts d ARG
do
   case "$ARG" in
   d) DEBUGGER="gdb --args ";;
   [?]) build_usage
        exit -1;;
   esac
done

$DEBUGGER../staging/bin/BrowserServer
