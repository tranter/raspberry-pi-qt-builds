#!/bin/sh
#
# Download and build Qt Creator for desktop
#
# Usage:  build-qtcreator.sh [-h] [-n]
# Options:
#
# -h   Help
# -n   No-execute, just show commands

# Qt Creator version to build
VERSION_MAJOR=4
VERSION_MINOR=6
VERSION_PATCH=2

# Qt version to build against
QT_VERSION_MAJOR=5
QT_VERSION_MINOR=11
QT_VERSION_PATCH=1

# Set if needed for a beta or RC version, e.g. "-beta4"
# Leave empty for release.
VERSION_SUFFIX=

# Number of parallel jobs to run
PAR=1

# Stop on error
set -e

# Build directory
BUILD_DIR=${HOME}/qtbuild

# Parse command line options
while getopts "hn" opt; do
  case $opt in
    h)
      echo "usage: $0 [-h] [-n] -[<n>]"
      echo ""
      echo "Options:"
      echo "  -h   Help"
      echo "  -n   No-execute, just show commands"
      exit
      ;;
    n)
      no_exec=1
      ;;
    \?)
      exit
      ;;
  esac
done

# Generate name of archive file
VER2="${VERSION_MAJOR}.${VERSION_MINOR}"
VER3="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
VER4="${QT_VERSION_MAJOR}.${QT_VERSION_MINOR}.${QT_VERSION_PATCH}"
SOURCE="qt-creator-opensource-src-${VER3}${VERSION_SUFFIX}.tar.xz"

# Name of source directory
DIR=`basename ${SOURCE} .tar.xz`

# Name of created build archive file
BUILD="QtCreator${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}-Qt${QT_VERSION_MAJOR}.${QT_VERSION_MINOR}.${QT_VERSION_PATCH}-RaspberryPi3-bin.tgz"

echo "*** Building Qt Creator ${VER3}${VERSION_SUFFIX}"
if [ ! -d "${BUILD_DIR}" ]
then
  if [ -n "$no_exec" ]
  then
      echo mkdir -p "${BUILD_DIR}"
  else
      mkdir -p "${BUILD_DIR}"
  fi
fi

if [ -n "$no_exec" ]
then
  echo cp qt-creator-arm.patch ${BUILD_DIR}
  echo cd ${BUILD_DIR}
else
  cp qt-creator-arm.patch ${BUILD_DIR}
  cd ${BUILD_DIR}
fi

# Download source if needed.
if [ -f "${SOURCE}" ]
then
  echo "*** Source found, not downloading it"
else
  echo "*** Downloading source"
  if [ -n "$no_exec" ]
  then
    echo wget http://download.qt.io/official_releases/qtcreator/${VER2}/${VER3}/${SOURCE}
  else
    wget http://download.qt.io/official_releases/qtcreator/${VER2}/${VER3}/${SOURCE}
  fi
fi

# Check that a build was not already extracted
if [ -d ${DIR} ]
then
  echo "A build already exists in ${DIR}"
  echo "Remove it before doing a build."
  exit 1
fi

# Extract source
echo "*** Extracting source"
if [ -n "$no_exec" ]
then
  echo tar xJf ${SOURCE}
  echo cd ${DIR}
else
  tar xJf ${SOURCE}
  cd ${DIR}
fi    

# Currently need to apply a patch to get a third party library to
# build on ARM.
echo "*** Applying patch"
if [ -n "$no_exec" ]
then
  echo "patch -p1 <../qt-creator-arm.patch"
else
  patch -p1 <../qt-creator-arm.patch
fi

# Run qmake (needs to be in path)
echo "*** Running qmake"
if [ -n "$no_exec" ]
then
  echo qmake
else
  qmake
fi

# Build
echo "*** Building"
if [ -n "$no_exec" ]
then
  echo make -s -j${PAR}
else
  make -s -j${PAR}
fi

# Build docs
echo "*** Building docs"
if [ -n "$no_exec" ]
then
  echo make -s -j${PAR} docs
else
  make -s -j${PAR} docs
fi

# Install
echo "*** Installing"
if [ -n "$no_exec" ]
then
  echo sudo make install INSTALL_ROOT=/usr/local/
else
  sudo make install INSTALL_ROOT=/usr/local/
fi

# Make tar file of build
echo "*** Making tar file"
if [ -n "$no_exec" ]
then
  echo cd ..
  echo tar czf ${BUILD} /usr/local/bin/q* /usr/local/share/icons /usr/local/share/qtcreator /usr/local/share/metainfo /usr/local/share/applications /usr/local/lib/qtcreator /usr/local/libexec/qtcreator
else
  cd ..
  tar czf ${BUILD} /usr/local/bin/q* /usr/local/share/icons /usr/local/share/qtcreator /usr/local/share/metainfo /usr/local/share/applications /usr/local/lib/qtcreator /usr/local/libexec/qtcreator
fi

# Remove source
echo "*** Removing source"
if [ -n "$no_exec" ]
then
  echo rm -rf ${DIR}
else
  rm -rf ${DIR}
fi

# Remove install
echo "*** Removing install"
if [ -n "$no_exec" ]
then
  echo sudo make uninstall INSTALL_ROOT=/usr/local/
else
  sudo make uninstall INSTALL_ROOT=/usr/local/
fi

# Done.
echo "*** Done, build is in ${BUILD}"
