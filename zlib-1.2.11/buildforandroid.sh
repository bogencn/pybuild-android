#!/bin/bash
COMPILE_ROOT=`pwd`
ANDROID_NDK_ROOT=/home/zte/Desktop/a2/android-ndk-r21b
ANDROID_GCC_ROOT=${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/linux-x86_64
ANDROID_GCC_PATH=${ANDROID_GCC_ROOT}/bin

BUILD_PATH=${COMPILE_ROOT}/build
OUT_PATH=${COMPILE_ROOT}/out

OPENSSL_PATH=/home/zte/Desktop/a2/openssl1.1.1d-prebuild
OPENSSL_LIB_PATH=/home/zte/Desktop/a2/openssl1.1.1d-prebuild/lib/arm64-v8a

CROSS_COMPILER=aarch64-linux-android-
CROSS_COMPILER_CLANG=aarch64-linux-android26-

#prepare
mkdir -p ${BUILD_PATH}
mkdir -p ${OUT_PATH}
export PATH=${ANDROID_NDK_ROOT}:${ANDROID_GCC_PATH}:$PATH

export ARCH="aarch64"
export CC="${CROSS_COMPILER_CLANG}clang -pie -fPIE" 
export CPP="${CROSS_COMPILER_CLANG}clang -E  -pie -fPIE"
export CXX="${CROSS_COMPILER_CLANG}clang++  -pie -fPIE"

export AS="${CROSS_COMPILER}as"
export LD="${CROSS_COMPILER}ld  -pie -fPIE"
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
export CONFIG_SITE="config.site"
export CXXFLAGS="-D__ANDROID_API__=26 "
LDFLAGS="-Wl,--allow-shlib-undefined -D__ANDROID_API__=26 -fPIC -L${OPENSSL_LIB_PATH}"
CFLAGS="-D__ANDROID_API__=26  "
CPPFLAGS="-D__ANDROID_API__=26"
cd ${BUILD_PATH}
pwd

../configure \
--prefix=${OUT_PATH}

make -j8 2>&1 |tee build.log
echo "-----------build success!-------------"

make install
echo "-----------install success!-------------"

