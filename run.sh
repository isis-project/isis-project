#!/bin/bash

LIBPATH=`readlink -f ../staging/lib`

if [ -z "$LD_LIBRARY_PATH" ] ; then
   export LD_LIBRARY_PATH=$LIBPATH
else
   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIBPATH
fi

export QT_PLUGIN_PATH=`readlink -f ../staging/plugins`
export QTWEBKIT_PLUGIN_PATH=`readlink -f ../staging/lib/BrowserPlugins`

echo $LIBPATH

cd ../isis-test
./isis-test -platform xlib

#cd ../WebKit/bin
#./QtTestBrowser -platform xlib ../../isis-browser/index.html
