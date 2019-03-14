#!/bin/bash

OPENSSL_VER='1.1.1b'
CURL_VER='7.64.0'
GMP_VER='6.1.2'

CORES=$(grep -c ^processor /proc/cpuinfo)

LOCAL_LIB="../lib"

export LDFLAGS="-L$LOCAL_LIB/curl-${CURL_VER}/lib/.libs -L$LOCAL_LIB/gmp-${GMP_VER}/.libs -L$LOCAL_LIB/openssl-${OPENSSL_VER}"

F="--with-curl=$LOCAL_LIB/curl-${CURL_VER} --with-crypto=$LOCAL_LIB/openssl-${OPENSSL_VER} --host=x86_64-w64-mingw32"

mkdir release
cp /usr/x86_64-w64-mingw32/lib/zlib1.dll release/
cp /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll release/
cp /usr/lib/gcc/x86_64-w64-mingw32/7.3-win32/libstdc++-6.dll release/
cp /usr/lib/gcc/x86_64-w64-mingw32/7.3-win32/libgcc_s_seh-1.dll release/
cp $LOCAL_LIB/openssl-${OPENSSL_VER}/libcrypto-1_1-x64.dll release/
cp $LOCAL_LIB/curl-${CURL_VER}/lib/.libs/libcurl-4.dll release/

make distclean || echo clean
rm -f config.status
./autogen.sh || echo done

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -march=znver1 -mtune=znver1 -msha -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-avx2-sha.exe

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -march=haswell -mtune=haswell -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-avx2.exe

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -march=sandybridge -mtune=sandybridge -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-avx.exe

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -march=westmere -mtune=westmere -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-aes-sse42.exe

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -march=nehalem -mtune=nehalem -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-sse42.exe

make clean || echo clean
rm -f config.status
CFLAGS="-Ofast -msse2 -Wall" ./configure $F
make -j ${CORES}
strip -s cpuminer.exe
mv cpuminer.exe release/cpuminer-sse2.exe

make clean || echo clean
