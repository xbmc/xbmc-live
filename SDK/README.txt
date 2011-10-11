Cronological flow of operations:

+------------------------+             Sets and Exports (according to cmdline):
| ./buildWithOptions.sh  |             * SDK_BUILDHOOKS
+------------------------+             * APT_HTTP_PROXY
          |                            * APT_FTP_PROXY
          |                            * KEEP_WORKAREA
          |
          |      +-------------+
          +------| ./build.sh  |
                 +-------------+
                        |
                        |     +------------------+       buildHook-grub2.sh
                        +-----| ./buildHook-*.sh |       buildHook-intelOnly.sh
                        |     +------------------+       buildHook-liveOnly.sh
                        |                                buildHook-nvidiaOnly.sh
                        |                                buildHook-proposed.sh
                        |                                buildHook-usbhddImage.sh
                        |                                buildHook-xbmcSvn.sh
                        |                                buildHook-xswat.sh
                        |
                        |     +-----------------------+
                        +-----| ./buildDEBs/build.sh  |
                        |     +-----------------------+
                        |                |
                        |                |      +------------------------+       build-installer.sh
                        |                +------| ./buildDEBs/build-*.sh |       build-live-boot.sh
                        |                       +------------------------+
                        |
                        |     +------------------+       copyFiles-addons.sh
                        +-----| ./copyFiles-*.sh |       copyFiles-crystalhd.sh
                        |     +------------------+       copyFiles-installer.sh
                        |                                copyFiles-liveBoot.sh
                        |                                copyFiles-plymouthThemeFIX.sh
                        |
                        |     +-----------------------+
                        +-----| ./buildLive/build.sh  |
                              +-----------------------+
                                         |
                                         |      +-------------------------+
                                         +------| ./buildLive/mkConfig.sh |
                                                +-------------------------+


Main script detailed sequence of operations (build.sh):

1. Check for required packages
2. Delete previous build objects (workarea, binary.*) if they exist
3. Create a new workarea, copying the entire SDK
4. If live-build is not installed, clone it from upstream repo and set environment accordingly
5. Execute any specified build hooks
6. Build any DEB/UDEB packages required for the Live build
7. Copy any built-downloaded files into buildLive directory tree for the "real" Live build
8. Perform Live build using live-build with the preconfigured, ad-hoc config tree


Oneiric support TODO

* Replace uxlaunch by lightdm (requires modifying xbmc-packaging)
* Test with XBMC oneric packages.
* Review the local hooks scripts. Some good examples can be found in /usr/share/live/build/scripts/build
* Review packages.list
* Fix W: Unknown package list '*.list.binary'
* Find proper solution for lb_binary_debian-installer
* Find solution for non-existing oneiric in /usr/share/live/build/data/debian-cd/

