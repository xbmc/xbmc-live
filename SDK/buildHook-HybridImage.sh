#!/bin/sh

#      Copyright (C) 2005-2008 Team XBMC
#      http://www.xbmc.org
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with XBMC; see the file COPYING.  If not, write to
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  http://www.gnu.org/copyleft/gpl.html

INITRAMFS=casper
BOOT_LOADER=grub2
BINARY_IMAGES=iso

if [ "$INITRAMFS" = "casper" ] ; then

   echo "Using casper initramfs system"

   rm -rf $WORKPATH/buildDEBs/build-installer.sh
   rm -rf $WORKPATH/buildDEBs/build-live-boot.sh
   rm -rf $WORKPATH/buildDEBs/build-live-config.sh
   rm -rf $WORKPATH/copyFiles-installer.sh
   rm -rf $WORKPATH/copyFiles-liveBoot.sh

   # We need casper in this case
   sed -i "s/INITRAMFS=live-boot/INITRAMFS=casper/g" $WORKPATH/buildLive/auto/config

   # No installer
   sed -i "s/INSTALLER=true/INSTALLER=false/g" $WORKPATH/buildLive/auto/config

   # Modify grub.cfg if needed
   sed -i "s/\/live\//\/casper\//g" $WORKPATH/buildLive/Files/config/binary_grub/grub.cfg
   sed -i "s/boot=live/boot=casper/g" $WORKPATH/buildLive/Files/config/binary_grub/grub.cfg

fi

if [ "$BINARY_IMAGES" = "iso-hybrid" ] ; then

   # Set the output to be an Hybrid iso disk image
   sed -i "s/BINARY_IMAGES=iso/BINARY_IMAGES=iso-hybrid/g" $WORKPATH/buildLive/auto/config

   if [ "$BOOT_LOADER" = "syslinux" ] ; then

      # We have to use syslinux in this case
      sed -i "s/BOOT_LOADER=grub2/BOOT_LOADER=syslinux/g" $WORKPATH/buildLive/auto/config

      # No grub
      sed -i "s/grub-pc/#grub-pc/g" $WORKPATH/buildLive/Files/config/package-lists/packages.list.chroot
      rm -rf $WORKPATH/buildLive/Files/config/binary_grub/
   fi
fi

if [ "$BINARY_IMAGES" = "hdd" ] ; then

   if [ "$BOOT_LOADER" ~ "grub" ] ; then
      echo "This combination won't work"
      exit 0
   fi

   # Set the output to be an USBHDD disk image
   sed -i "s/BINARY_IMAGES=iso/BINARY_IMAGES=hdd/g" $WORKPATH/buildLive/auto/config

   if [ "$BOOT_LOADER" = "syslinux" ] ; then

      # We have to use syslinux in this case
      sed -i "s/BOOT_LOADER=grub2/BOOT_LOADER=syslinux/g" $WORKPATH/buildLive/auto/config

      # No grub
      sed -i "s/grub-pc/#grub-pc/g" $WORKPATH/buildLive/Files/config/package-lists/packages.list.chroot
      rm -rf $WORKPATH/buildLive/Files/config/binary_grub/

      #workaround for Bug#622838 syslinux-live and hdd images
      THISDIR=$(pwd)
      mkdir -p $WORKPATH/buildLive/Files/config/includes.chroot/usr/share/syslinux/themes/ubuntu-oneiric/isolinux-live
      cd $WORKPATH/buildLive/Files/config/includes.chroot/usr/share/syslinux/themes/ubuntu-oneiric/
      ln -s isolinux-live syslinux-live
      cd isolinux-live
      ln -s isolinux.cfg syslinux.cfg
      cd $THISDIR

   fi
fi
