#!/bin/bash
set -e
set -x

VER=13.10
VERSHORT=$(echo $VER | sed 's/\(^[0-9][0-9]*\.[0-9][0-9]*\).*/\1/g')
FILE=ubuntu-core-${VER}-core-amd64.tar.gz
URL=http://cdimage.ubuntu.com/ubuntu-core/releases/${VERSHORT}/release/${FILE}
SHA256SUMURL=http://cdimage.ubuntu.com/ubuntu-core/releases/${VERSHORT}/release/SHA256SUMS

check()
{
  grep $FILE SHA256SUMS | sha256sum -c
}

if [ -f SHA256SUMS ]
then
  rm -f SHA256SUMS
fi

wget $SHA256SUMURL

if [ -e $FILE ]
then
  if ! check
  then
    rm -f $FILE
  fi
fi

if [ ! -e $FILE ]
then
  wget $URL
  check
fi

cat $FILE | docker import - ibuildthecloud/ubuntu-core:${VER}
