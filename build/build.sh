#!/bin/bash
COMPILE_ROOT=`pwd`
ANDROID_NDK_ROOT=/path_to_NDK/android-ndk-r21b
ANDROID_GCC_ROOT=${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-x86_64
ANDROID_GCC_PATH=${ANDROID_GCC_ROOT}/bin

CROSS_COMPILER=arm-linux-androideabi-
CROSS_COMPILER_CLANG=armv7a-linux-androideabi26-

#prepare
export PATH=${ANDROID_NDK_ROOT}:${ANDROID_GCC_PATH}:$PATH

export ARCH="armv7a"
export CC="${CROSS_COMPILER_CLANG}clang" 
export CXX="${CROSS_COMPILER_CLANG}clang++"

export AS="${CROSS_COMPILER}as"
export LD="${CROSS_COMPILER}ld"
export GDB="${CROSS_COMPILER}gdb"
export STRIP="${CROSS_COMPILER}strip"
export RANLIB="${CROSS_COMPILER}ranlib"
export OBJCOPY="${CROSS_COMPILER}objcopy"
export OBJDUMP="${CROSS_COMPILER}objdump"
export AR="${CROSS_COMPILER}ar"
export NM="${CROSS_COMPILER}nm"
export READELF="${CROSS_COMPILER}readelf"
export TARGET_PREFIX=$CROSS_COMPILER
export CONFIG_SITE="config.site"
export CXXFLAGS="-D__ANDROID_API__=26 "

./buildcrypt.sh
./buildzlib.sh
./buildlibressl.sh
./buildpython.sh
./setsoname.sh

