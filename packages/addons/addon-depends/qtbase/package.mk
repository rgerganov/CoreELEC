# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qtbase"
PKG_VERSION="5.6.2"
PKG_SHA256="7551f5af1312082c3c8ab52f5e102e3f83aae2dd96dc4a3a9a197f3e58b3214c"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="https://download.qt.io/new_archive/qt/5.6/5.6.2/single/qt-everywhere-opensource-src-5.6.2.tar.gz"
PKG_DEPENDS_TARGET="freetype libjpeg-turbo libpng openssl sqlite zlib icu"
PKG_LONGDESC="A cross-platform application and UI framework."
PKG_BUILD_FLAGS="-sysroot"

#-device-option CROSS_COMPILE=/media/Storage/arm/output/meson8b_m201/host/usr/bin/arm-linux-gnueabihf-
#-device-option 'BR_COMPILER_CFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os  ' 
#-device-option 'BR_COMPILER_CXXFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os  ' 

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr
                           -hostprefix "${TOOLCHAIN}"
						   -headerdir /usr/include/qt5 
                           -sysroot "${SYSROOT_PREFIX}"
						   -plugindir /usr/lib/qt/plugins
						   -examplesdir /usr/lib/qt/examples 
						   -no-rpath 
						   -nomake tests
						   -device linux-libreelec-g++
						   -optimized-qmake 
						   -no-cups 
						   -no-iconv 
						   -system-zlib 
						   -system-pcre 
						   -no-pch 
						   -shared 
						   -no-kms 
						   -release 
						   -largefile 
						   -opensource 
						   -confirm-license 
						   -no-sql-mysql 
						   -no-sql-psql 
						   -system-sqlite 
						   -gui 
						   -widgets 
						   --enable-linuxfb 
						   -directfb 
						   -no-xcb 
						   -opengl es2 
						   -eglfs 
						   -no-openssl 
						   -fontconfig 
						   -system-libjpeg 
						   -system-libpng 
						   -dbus 
						   -no-tslib 
						   -glib 
						   -icu 
						   -make examples 
						   -skip qtconnectivity
						   -no-gstreamer"

configure_target() {
  QMAKE_CONF_DIR="qtbase/mkspecs/devices/linux-libreelec-g++"

  cd ..
  mkdir -p ${QMAKE_CONF_DIR}

  cat >"${QMAKE_CONF_DIR}/qmake.conf" <<EOF
MAKEFILE_GENERATOR       = UNIX
CONFIG                  += incremental
QMAKE_INCREMENTAL_STYLE  = sublib
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
load(device_config)
QMAKE_CC                = $CC
QMAKE_CXX               = $CXX
QMAKE_LINK              = $CXX
QMAKE_LINK_SHLIB        = $CXX
QMAKE_AR                = $AR cqs
QMAKE_OBJCOPY           = $OBJCOPY
QMAKE_NM                = $NM -P
QMAKE_STRIP             = $STRIP
QMAKE_CFLAGS = $CFLAGS
QMAKE_CXXFLAGS = $CXXFLAGS
QMAKE_LFLAGS = $LDFLAGS
load(qt_config)
EOF

  cat >"${QMAKE_CONF_DIR}/qplatformdefs.h" <<EOF
#include "../../linux-g++/qplatformdefs.h"
EOF

  unset CC CXX LD RANLIB AR AS CPPFLAGS CFLAGS LDFLAGS CXXFLAGS
  ./configure ${PKG_CONFIGURE_OPTS_TARGET}
}
