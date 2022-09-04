# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qtwebkit"
PKG_VERSION="ac8ebc6c3a56064f88f5506e5e3783ab7bee2456"
PKG_SHA256="405b32de1ac1921759190ef68b7dcb7620c545d0055a84ea8e1ba7b86b3d6dc4"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/qt/qtwebkit"
PKG_URL="https://github.com/qt/qtwebkit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain qtbase"
PKG_LONGDESC="qtwebkit"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-G Ninja -DPORT=Qt -DUSE_LIBHYPHEN=OFF -DUSE_GSTREAMER=OFF -DUSE_GSTREAMER_DEFAULT=OFF -DCMAKE_BUILD_TYPE=Release"
