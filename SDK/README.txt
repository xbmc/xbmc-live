Cronological flow of operations:

+------------------------+             Sets and Exports (according to cmdline):
| ./buildWithOptions.sh  |             * SDK_BUILDHOOKS
+------------------------+             * VARIANT_NAME
          |                            * APT_HTTP_PROXY
          |                            * APT_FTP_PROXY
          |                            * KEEP_WORKAREA
          |                                                                     (**) = distro-variant scripts
          |      +-------------+
          +------| ./build.sh  |
                 +-------------+
                        |
                        |     +------------------------+       buildHook-grub2.sh
                        +-----| ./buildHook-*.sh  (**) |       buildHook-intelOnly.sh
                        |     +------------------------+       buildHook-liveOnly.sh
                        |                                      buildHook-nvidiaOnly.sh
                        |                                      buildHook-proposed.sh
                        |                                      buildHook-usbhddImage.sh
                        |                                      buildHook-xbmcSvn.sh
                        |                                      buildHook-xswat.sh
                        |
                        |     +-----------------------+
                        +-----| ./buildDEBs/build.sh  |
                        |     +-----------------------+
                        |                |
                        |                |      +------------------------------+       build-installer.sh
                        |                +------| ./buildDEBs/build-*.sh  (**) |       build-live-boot.sh
                        |                       +------------------------------+       build-live-initramfs.sh
                        |
                        |      +--------------------------------+
                        +------| ./buildBinaryDrivers/build.sh  |
                               +--------------------------------+
                        |                |
                        |                |      +---------------------------------------+       build-AMD.sh
                        |                +------| ./buildBinaryDrivers/build-*.sh  (**) |       build-NVIDIA.sh
                        |                       +---------------------------------------+       build-CrystalHD.sh
                        |
                        |     +------------------------+       copyFiles-addons.sh
                        +-----| ./copyFiles-*.sh  (**) |       copyFiles-crystalhd.sh
                        |     +------------------------+       copyFiles-initramfs.sh
                        |                                      copyFiles-installer.sh
                        |                                      copyFiles-liveBoot.sh
                        |                                      copyFiles-plymouthThemeFIX.sh
                        |                                      copyFiles-restricted.sh
                        |
                        |     +-----------------------+
                        +-----| ./buildLive/build.sh  |
                              +-----------------------+
                                         |
                                         |      +-------------------------------+
                                         +------| ./buildLive/mkConfig.sh  (**) |
                                                +-------------------------------+
