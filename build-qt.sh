#!/bin/sh
#
# Download and build Qt for desktop

# Qt version to build
VERSION_MAJOR=5
VERSION_MINOR=10
VERSION_PATCH=1

# Set if needed for a beta or RC version, e.g. "-beta4"
# Leave empty for release.
VERSION_SUFFIX=

# Build type, "full" or "minimal"
#BUILD_TYPE="full"
BUILD_TYPE="minimal"

# Number of parallel jobs to run
PAR=1

# Stop on error
set -e

# Build directory
BUILD_DIR=${HOME}/qtbuild

# Generate name of archive file
VER2="${VERSION_MAJOR}.${VERSION_MINOR}"
VER3="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
SOURCE="qt-everywhere-src-${VER3}${VERSION_SUFFIX}.tar.xz"
#SOURCE="qt-everywhere-opensource-src-${VER3}${VERSION_SUFFIX}.tar.xz"

# Name of source directory
DIR=`basename ${SOURCE} .tar.xz`

# Name of created build archive file
if [ ${BUILD_TYPE} = "full" ]
then
    BUILD="Qt${VERION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}-RaspberryPi3-bin-full.tgz"
elif [ ${BUILD_TYPE} = "minimal" ]
then
    BUILD="Qt${VERION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}-RaspberryPi3-bin-minimal.tgz"
else
    echo "Unknown build type: ${BUILD_TYPE}"
    exit 1
fi

echo "*** Building Qt ${VER3}${VERSION_SUFFIX}"

if [ ! -d "${BUILD_DIR}" ]
then
    mkdir -p "${BUILD_DIR}"
fi
cd ${BUILD_DIR}

# Download source if needed.
if [ -f "${SOURCE}" ]
then
  echo "*** Source found, not downloading it"
else
  echo "*** Downloading source"
  wget http://download.qt.io/official_releases/qt/${VER2}/${VER3}/single/${SOURCE}
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

# Remove modules that are too big to build natively.
rm -rf qtlocation qtwebengine

# Configure
echo "*** Configuring"
if [ ${BUILD_TYPE} = "minimal" ]
then
    ./configure -opensource -confirm-license -nomake examples -nomake tests
else
    ./configure -opensource -confirm-license
fi

# Build
echo "*** Building"
make -s -j${PAR}

# Install
echo "*** Installing"
sudo make -s install

# Build docs
if [ ${BUILD_TYPE} = "full" ]
then
  echo "*** Building docs"
  make -s -j${PAR} docs
fi

# Install docs
if [ ${BUILD_TYPE} = "full" ]
then
  echo "*** Installing docs"
  sudo make -s install_docs
fi

# Make tar file of build
tar czf ${BUILD} /usr/local/Qt-${VERION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}

# Remove source
cd ..
#rm -rf ${DIR}

# Remove install
#sudo rm -rf /usr/local/Qt-${VERION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}

# Done.
echo "*** Done, build is in ${BUILD}"
