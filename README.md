# raspberry-pi-qt-builds

Qt builds for the Raspberry Pi platform

# Overview

This project contains scripts for building Qt natively on the Raspberry Pi platform. It includes the Qt libraries and tools (e.g. qmake) for developing Qt-based applications on the Raspberry Pi. Also included are binaries (in the form of tar archives) for various versions of Qt that will run under the Raspbian Linux distribution. As building Qt natively is very time consuming, these are provided for the convenience of developers who want to use a recent version of Qt on the Raspberry Pi platform running Raspbian.

# Features

These builds support the latest Qt "recommended" and "long term support" releases. The downloads include both a "full" version as well as a "minimal" version which does not include the Qt documentation or example applications. The builds are provided in the form of tar archives which can be extracted on a Raspberry Pi system running Raspbian. The table below lists the current binary builds.

| Qt Version | Platform       | Type   | Options | Size   | Comments            |
| ---------- | -------------- | -------| ------- | ------ | ------------------- |
| 5.9.4      | Raspberry Pi 3 | Native | Full    | 439MB  |                     |
| 5.9.4      | Raspberry Pi 3 | Native | Minimal |  55MB  | No examples or docs |
| 5.10.1     | Raspberry Pi 3 | Native | Full    | 453MB  |                     |
| 5.10.1     | Raspberry Pi 3 | Native | Minimal |  58MB  | No examples or docs |


| Qt Creator Version | Platform       | Type   | Options | Size   | Comments            |
| ------------------ | -------------- | -------| ------- | ------ | ------------------- |
| 4.6.0              | Raspberry Pi 3 | Native | Full    | 307MB  |                     |

The builds include most Qt modules (see below under "Known Issues and Limitations"). The following rendering back ends are included: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, webgl, xcb.

# Building

If you want to build these images yourself, you can run the provided script (qtbuild.sh) on a Raspberry Pi system. It is recommended that you configure the system (using raspi-config) to boot into a text console and not run the graphical desktop. I have had issues with the Raspberry Pi rebooting during the build. If so, you can manually restart it.

There are a number of packages which need to be installed in order to built Qt. Here is a list which may not be entirely complete or accurate (you can install them with sudo apt-get <package names...>):

```
autotools-dev bison build-essential default-libmysqlclient-dev
dpkg-dev firebird-dev flex freetds-dev gstreamer1.0-alsa
gstreamer1.0-libav gstreamer1.0-omx gstreamer1.0-omx-rpi
gstreamer1.0-omx-rpi-config gstreamer1.0-plugins-bad
gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-x
icu-devtools libasound2-dev libatk1.0-dev libatk-bridge2.0-dev
libatspi2.0-dev libaudit-dev libavcodec-dev libavformat-dev
libbison-dev libbsd-dev libc6-dev libcairo2-dev libcap-ng-dev
libc-dev-bin libcups2-dev libcupsimage2-dev libdbus-1-dev
libdevmapper-dev libdmx-dev libdouble-conversion-dev libdrm-dev
libegl1-mesa-dev libepoxy-dev libexpat1-dev libfontconfig1-dev
libfontenc-dev libfreetype6-dev libgbm-dev libgcc-6-dev
libgcrypt20-dev libgdk-pixbuf2.0-dev libgl1-mesa-dev libgles2-mesa-dev
libglib2.0-dev libglu1-mesa-dev libgmp-dev libgpg-error-dev
libgraphite2-dev libgstreamer1.0 libgstreamer1.0-0 libgstreamer1.0-dev
libgstreamer-plugins-bad1.0-0 libgstreamer-plugins-base1.0-0
libgstreamer-plugins-base1.0-dev libgtk-3-dev libharfbuzz-dev
libhunspell-dev libice-dev libicu-dev libinput-dev libjbig-dev
libjpeg62-turbo-dev libjpeg-dev libltdl-dev liblzma-dev
libmariadbclient-dev libmariadbclient-dev-compat libmnl-dev
libmtdev-dev libpango1.0-dev libpciaccess-dev libpcre3-dev
libpipeline-dev libpixman-1-dev libpng-dev libpq-dev libproxy-dev
libpthread-stubs0-dev libpulse-dev libpython2.7-dev libpython3.5-dev
libpython3-dev libpython-all-dev libpython-dev libqt5opengl5-dev
libqt5webkit5-dev libraspberrypi-dev librtimulib-dev libselinux1-dev
libsepol1-dev libsgutils2-dev libsm-dev libsqlite3-dev libssl1.0-dev
libstdc++-6-dev libswscale-dev libsystemd-dev libtiff5-dev libudev-dev
libwayland-dev libx11-dev libx11-xcb1 libx11-xcb-dev libxau-dev
libxaw7-dev libxcb1 libxcb1-dev libxcb-dri2-0-dev libxcb-dri3-dev
libxcb-glx0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-image0
libxcb-image0-dev libxcb-keysyms1 libxcb-keysyms1-dev
libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev
libxcb-render-util0 libxcb-render-util0-dev libxcb-shape0-dev
libxcb-shm0 libxcb-shm0-dev libxcb-sync0-dev libxcb-sync1
libxcb-sync-dev libxcb-util0-dev libxcb-xf86dri0-dev
libxcb-xfixes0-dev libxcb-xinerama0 libxcb-xinerama0-dev
libxcb-xkb-dev libxcb-xv0-dev libxcomposite-dev libxcursor-dev
libxdamage-dev libxdmcp-dev libxext-dev libxfixes-dev libxfont-dev
libxft-dev libxi-dev libxinerama-dev libxkbcommon-dev
libxkbcommon-x11-dev libxkbfile-dev libxml2-dev libxmu-dev libxmuu-dev
libxpm-dev libxrandr-dev libxrender-dev libxres-dev libxshmfence-dev
libxt-dev libxtst-dev libxv-dev libxxf86vm-dev linux-libc-dev
manpages-dev mesa-common-dev nettle-dev python2.7-dev python3.5-dev
python3-dev python3-smbus python-all-dev python-dev python-smbus
qtbase5-dev qtbase5-dev-tools qtbase5-private-dev qtdeclarative5-dev
qtdeclarative5-private-dev qttools5-dev-tools ruby unixodbc-dev
x11proto-bigreqs-dev x11proto-composite-dev x11proto-core-dev
x11proto-damage-dev x11proto-dmx-dev x11proto-dri2-dev
x11proto-dri3-dev x11proto-fixes-dev x11proto-fonts-dev
x11proto-gl-dev x11proto-input-dev x11proto-kb-dev
x11proto-present-dev x11proto-randr-dev x11proto-record-dev
x11proto-render-dev x11proto-resource-dev x11proto-scrnsaver-dev
x11proto-video-dev x11proto-xcmisc-dev x11proto-xext-dev
x11proto-xf86bigfont-dev x11proto-xf86dga-dev x11proto-xf86dri-dev
x11proto-xf86vidmode-dev x11proto-xinerama-dev xtrans-dev xutils-dev
zlib1g-dev
```

Expect the build to take many hours on a Raspberry Pi 3 (on the order of eight hours for the minimal build, 24 hours for a full build).

# Installing

Download the desired binary archive, e.g. Qt5.10.1-RaspberryPi3-bin-full.tgz, and then install it using commands like this:

```
cd /
sudo tar xf /home/pi/Qt5.10.1-RaspberryPi3-bin-full.tgz
```

You can then run qmake specifying the full path, e.g. /usr/local/Qt-5.10.1/bin/qmake. You may want to add the Qt binary directory (e.g. /usr/local/Qt-5.10.1/bin) to your path.

# Known Issues and Limitations

The binaries have only had minimal testing. Both the xcb and eglfs rendering back ends should work and there is support for both widgets and QML.

The binaries support Raspbian Linux and the Raspberry Pi 3 only.

The QtWebengine and QtLocation modules are not included as they require more memory to build than is available on a Raspberry Pi 3.

# Future Plans

The following are some features that are being considered for the future:

- Add QtWebEngine and QtLocation modules
- Offer Debian format packages
- Provide cross-compilation packages
- Add builds for other Raspberry Pi models

# References

1. https://wiki.qt.io/Native_Build_of_Qt5_on_a_Raspberry_Pi
2. https://wiki.qt.io/Native_Build_of_Qt_5.4.1_on_a_Raspberry_Pi

# Legal Disclaimer

This software is provided "as is" and any expressed or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. in no event shall ICS or its contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.
