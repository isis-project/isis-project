#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
ISIS_PROJECT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $ISIS_PROJECT

LIBPATH=`readlink -f ../staging/lib`

if [ -z "$LD_LIBRARY_PATH" ] ; then
   export LD_LIBRARY_PATH=$LIBPATH
else
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBPATH
fi

export QT_PLUGIN_PATH=`readlink -f ../staging/plugins`
export QTWEBKIT_PLUGIN_PATH=`readlink -f ../staging/lib/BrowserPlugins`

echo $LIBPATH

cd ../qmlbrowser/qmlbrowser
./webbrowser -platform xlib $1


