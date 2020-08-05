#!/bin/bash
COMPILE_ROOT=`pwd`

export BUILD_PATH=${COMPILE_ROOT}/libcrypt
export SRC=${COMPILE_ROOT}/../libcrypt
export OUTPUT=${COMPILE_ROOT}/libcryptout
if [ ! -d libcryptout  ];then
  mkdir libcryptout
fi

if [ ! -d libcrypt  ];then
  mkdir libcrypt
fi


pushd ${BUILD_PATH}


make -f ../cryptMakefile

echo "-----------build success!-------------"

make -f ../cryptMakefile install
echo "-----------install success!-------------"
popd
