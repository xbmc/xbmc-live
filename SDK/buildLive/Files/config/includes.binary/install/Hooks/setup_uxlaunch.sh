#!/bin/sh

xbmcUser=$(getent passwd 1000 | sed -e 's/\:.*//')

sed -i "s/^user=.*/user=$xbmcUser/" /etc/uxlaunch/uxlaunch
