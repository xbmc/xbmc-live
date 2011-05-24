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

if ! ls live-boot_*.deb > /dev/null 2>&1 ; then
	echo "Retrieving live-boot package..."

	latestPackage1="live-boot_3.0~a17-1_all.deb"
	latestPackage2="live-boot-initramfs-tools_3.0~a17-1_all.deb"

	wget -q "http://ftp.debian.org/debian/pool/main/l/live-boot/$latestPackage1"
	if [ "$?" -ne "0" ] || [ ! -f $latestPackage1 ] ; then
		echo "Needed package (1) not found, exiting..."
		exit 1
	fi

	wget -q "http://ftp.debian.org/debian/pool/main/l/live-boot/$latestPackage2"
	if [ "$?" -ne "0" ] || [ ! -f $latestPackage2 ] ; then
		echo "Needed package (2) not found, exiting..."
		exit 1
	fi
fi
