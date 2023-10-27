# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qtbase"
PKG_VERSION="5.14.2"
PKG_SHA256="c6fcd53c744df89e7d3223c02838a33309bd1c291fcb6f9341505fe99f7f19fa"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="https://download.qt.io/archive/qt/5.14/5.14.2/single/qt-everywhere-src-5.14.2.tar.xz"
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
						   -no-rpath 
						   -nomake tests
						   -nomake examples
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
						   -opensource 
						   -confirm-license 
						   -no-sql-mysql 
						   -no-sql-psql 
						   -system-sqlite 
						   -gui 
						   -widgets 
						   --enable-linuxfb 
						   -no-xcb 
                           -opengl es2 
                           -eglfs 
						   -qpa eglfs
						   -openssl-linked
						   -fontconfig 
						   -system-libjpeg 
						   -system-libpng 
						   -dbus 
						   -no-tslib 
						   -glib 
						   -icu 
						   -skip qtconnectivity
						   -skip qtlocation
						   -skip qtsensors
						   -skip qtcanvas3d
						   -skip qt3d
						   -skip qtsvg
						   -skip qtserialbus
						   -skip qtserialport
						   -skip qtpurchasing
						   -skip qtwebengine
						   -skip qtcharts
						   -skip qtscript
						   -skip qtquick3d
						   -skip qtgamepad
						   -skip qtwebsockets
						   -skip qtspeech
						   -skip qtmultimedia"

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
