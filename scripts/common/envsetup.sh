#!/bin/sh

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

cd $STARTDIR

fail()
{
   cd $STARTDIR
   echo $1
   exit 1
}
