#!/bin/bash
COMPILE_ROOT=`pwd`
ANDROID_NDK_ROOT=/home/zte/Desktop/a2/android-ndk-r21b
ANDROID_GCC_ROOT=${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-x86_64
ANDROID_GCC_PATH=${ANDROID_GCC_ROOT}/bin

BUILD_PATH=${COMPILE_ROOT}/build
OUT_PATH=${COMPILE_ROOT}/out

CROSS_COMPILER=arm-linux-androideabi-
CROSS_COMPILER_CLANG=armv7a-linux-androideabi26-

#prepare
mkdir -p ${BUILD_PATH}
mkdir -p ${OUT_PATH}
export PATH=${ANDROID_NDK_ROOT}:${ANDROID_GCC_PATH}:$PATH

export ARCH="aarch64"
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
export M4=m4
export TARGET_PREFIX=$CROSS_COMPILER
export CXXFLAGS="-D__ANDROID_API__=26 "
export LDFLAGS="-Wl,--allow-shlib-undefined -D__ANDROID_API__=26"
export CFLAGS="-D__ANDROID_API__=26  -fPIC"
export CPPFLAGS="-D__ANDROID_API__=26 -fPIC"
cd ${BUILD_PATH}
pwd

../configure \
--prefix=${OUT_PATH}

make -j8 2>&1 |tee build.log
echo "-----------build success!-------------"

make install
echo "-----------install success!-------------"

