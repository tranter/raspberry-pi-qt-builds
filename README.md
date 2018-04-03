# raspberry-pi-qt-builds

Qt builds for the Raspberry Pi platform

# Overview

This project contains scripts for building Qt natively on the Raspberry Pi platform. It includes the Qt libraries and tools (e.g. qmake) for developing Qt-based applications on the Raspberry Pi. Also included are binaries (in the form of tar archives) for various versions of Qt that will run under the Raspbian Linux distribution. As building Qt natively is very time consuming, these are provided for the convenience of developers who want to use a recent version of Qt on the Raspberry Pi platform running Raspbian.

# Features

These builds support the latest Qt "recommended" and "long term support" releases. The downloads include both a "full" version as well as a "minimal" version which does not include the Qt documentation or example applications. The builds are provided in the form of tar archives which can be extracted on a Raspberry Pi system running Raspbian. The table below lists the current binary builds.

| Qt Version | Platform       | Type   | Options | Size   | Comments            |
| ---------- | -------------- | -------| ------- | ------ | ------------------- |
| 5.9.4      | Raspberry Pi 3 | Native | Full    | 442MB  |                     |
| 5.9.4      | Raspberry Pi 3 | Native | Minimal |  58MB  | No examples or docs |
| 5.10.1     | Raspberry Pi 3 | Native | Full    | 453MB  |                     |
| 5.10.1     | Raspberry Pi 3 | Native | Minimal |  58MB  | No examples or docs |

The builds include most Qt modules (see below under "Known Issues and Limitations"). The folllowing rendering back ends are included: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, webgl, xcb.

# Building

If you want to build these images yourself, you can run the provided script (qtbuild.sh) on a Raspberry Pi system. It is recommended that you configure the system (using raspi-config) to boot into a text console and not run the graphical desktop. I have had issues with the Raspberry Pi rebooting during the build. I seem to have better success running a build from ssh rather than locally on a text console.

There are a number of development packages which need to be installed in order to built Qt. This will documented here in the future. For now, see references 1 and 2.

Expect the build to take many hours on a Raspberry Pi 3 (on the order of eight hours for the minimal build).

# Installing

Download the desired binary archive, e.g. Qt5.10.1-RaspberryPi3-bin-full.tgz, and then install it using commands like this:

```
cd /
sudo tar xf Qt5.10.1-RaspberryPi3-bin-full.tgz
```

You can then run qmake specifying the full path, e.g. /usr/local/Qt-5.10.1/bin/qmake. You may want to add the Qt binary directory (e.g. /usr/local/Qt-5.10.1/bin) to your path.

# Known Issues and Limitations

The binaries have only had minimal testing. Both the xcb and eglfs rendering back ends should work and there is support for both widgets and QML.

The binaries support Raspbian Linux and the Raspberry Pi 3 only.

The QtWebengine and QtLocation modules are not included as they require more memory to build than is available on a Raspberry Pi 3.

# Future Plans

The following are some features that are being considered for the future:

- Offer Qt Creator binaries
- Add QtWebEngine and QtLocation modules
- Offer Debian format packages
- Provide cross-compilation packages
- Add builds for other Raspberry Pi models

# References

1. https://wiki.qt.io/Native_Build_of_Qt5_on_a_Raspberry_Pi
2. https://wiki.qt.io/Native_Build_of_Qt_5.4.1_on_a_Raspberry_Pi

# Legal Disclaimer

This software is provided "as is" and any expressed or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. in no event shall ICS or its contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.
