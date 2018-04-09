#!/bin/sh
#
# Download and build Qt Creator for desktop

# Qt version to build
VERSION_MAJOR=4
VERSION_MINOR=6
VERSION_PATCH=0

# Set if needed for a beta or RC version, e.g. "-beta4"
# Leave empty for release.
VERSION_SUFFIX=

# Number of parallel jobs to run
PAR=6

# Stop on error
set -e

# Build directory
BUILD_DIR=${HOME}/qtbuild

# Generate name of archive file
VER2="${VERSION_MAJOR}.${VERSION_MINOR}"
VER3="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
SOURCE="qt-creator-opensource-src-${VER3}${VERSION_SUFFIX}.tar.xz"

# Name of source directory
DIR=`basename ${SOURCE} .tar.xz`

# Name of created build archive file
BUILD="QtCreator${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}-RaspberryPi3-bin.tgz"

echo "*** Building Qt Creator ${VER3}${VERSION_SUFFIX}"

if [ ! -d "${BUILD_DIR}" ]
then
    mkdir -p "${BUILD_DIR}"
fi
cp qt-creator-arm.patch ${BUILD_DIR}
cd ${BUILD_DIR}

# Download source if needed.
if [ -f "${SOURCE}" ]
then
  echo "*** Source found, not downloading it"
else
  echo "*** Downloading source"
  wget http://download.qt.io/official_releases/qtcreator/${VER2}/${VER3}/${SOURCE}
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
tar xJf ${SOURCE}
cd ${DIR}

# Currently need to apply a patch to get a third party library to
# build on ARM.
echo "*** Applying patch"
patch -p1 <../qt-creator-arm.patch

# Run qmake (needs to be in path)
echo "*** Running qmake"
qmake

# Build
echo "*** Building"
make -s -j${PAR}

# Build docs
echo "*** Building docs"
make -s -j${PAR} docs

# Install
sudo make install INSTALL_ROOT=/usr/local/

# Make tar file of build
cd ..
tar czf ${BUILD} /usr/local/bin/q* /usr/local/share/icons /usr/local/share/qtcreator /usr/local/share/metainfo /usr/local/share/applications /usr/local/lib/qtcreator /usr/local/libexec/qtcreator

# Remove source
rm -rf ${DIR}

# Remove install
sudo make uninstall INSTALL_ROOT=/usr/local/

# Done.
echo "*** Done, build is in ${BUILD}"
