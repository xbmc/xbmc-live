#!/bin/bash

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

THISDIR=$(pwd)
WORKDIR=workarea

# TODO: proper required packages for debian installer inclusion when building Ubuntu
if [ -f /usr/share/live/build/scripts/build/lb_binary_debian-installer ]
then
    sed -i "s/DI_REQ_PACKAGES=\"elilo lilo grub grub-pc\"/DI_REQ_PACKAGES=\"grub-pc\"/g" /usr/share/live/build/scripts/build/lb_binary_debian-installer
    sed -i "s/DI_PACKAGES=\"\${DI_PACKAGES} busybox cryptsetup mdadm lvm2\"/DI_PACKAGES=\"\${DI_PACKAGES} cryptsetup mdadm lvm2\"/g" /usr/share/live/build/scripts/build/lb_binary_debian-installer
fi

# TODO: remove symbolic link once oneiric has come with the latest build-live package
if [ ! -d "/usr/share/live/build/data/debian-cd/oneiric" ];
then
    ln -s /usr/share/live/build/data/debian-cd/maverick /usr/share/live/build/data/debian-cd/oneiric
fi

build()
{
        lb build

        # safeguard against crashes
        lb chroot_devpts remove
        lb chroot_proc remove
        lb chroot_sysfs remove

        for modulesdir in chroot/lib/modules/*
        do
                umount $modulesdir/volatile &> /dev/null
        done
}

rm -rf cache/ chroot/ config/ auto/

if ! which lb > /dev/null ; then
        echo "A required package (live-build) is not available, exiting..."
        exit 1
fi

#
#
#

# Clean any previous run
rm -rf *.iso &> /dev/null

# Create auto dir, needed for live-build 3.0
cp Files/auto/ auto/ -rf

# Export needed for live-build 3.0
export PROJECT=ubuntu SUITE=oneiric ARCH=i386 BINARYFORMAT=iso

# Clean any previous run
lb clean

# Create config tree
lb config

# Copy package lists
cp -R Files/package-lists config

# Copy files for chroot
cp -R Files/chroot_* config

# Copy files for ISO
cp -R Files/binary_* config

# Copy package lists
cp -R Files/packages config

# Create chroot and build drivers
build

cd $THISDIR

# Get files from chroot
#mv $WORKDIR/binary.* .
