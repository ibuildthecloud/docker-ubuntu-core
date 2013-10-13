#!/bin/bash
set -e
set -x

VER=12.04.3
FILE=ubuntu-core-${VER}-core-amd64.tar.gz
URL=http://cdimage.ubuntu.com/ubuntu-core/releases/12.04/release/${FILE}
SHA1SUM=b348c16413da78b02442e36c26afb88419166014

if [ -e $FILE ]
then
  if ! echo "$SHA1SUM "'*'"$FILE" | sha1sum -c -
  then
    rm -f $FILE
  fi
fi

if [ ! -e $FILE ]
then
  wget $URL
fi

cat $FILE | docker import - ibuildthecloud/ubuntu-core ${VER}
