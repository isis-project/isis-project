#!/bin/sh

QMAKE=qmake
STARTDIR=$PWD

while [ "$PWD" != "/" -a "$ISIS_ROOT" = "" ] ; do
   if [ -d ./isis-project ] ; then
      ISIS_ROOT=$PWD
   else
      cd ..
   fi
done

echo $ISIS_ROOT

export LUNA_STAGING=$ISIS_ROOT/staging

if [ $BUILD_QT = "true" ] ; then
   export QTDIR=$ISIS_ROOT/qt
   QMAKE=$LUNA_STAGING/bin/qmake
fi

cd $STARTDIR

fail()
{
   cd $STARTDIR
   echo $1
   exit 1
}
