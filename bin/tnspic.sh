#!/bin/bash
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80
PBCMD="/home/pi/Downloads/pushbullet-bash/pushbullet"
FSCMD="/usr/bin/fswebcam"
FSARG="-r 640x480 --jpeg 85"
IMG=/tmp/img.$$
## Run fswebcam and save image
$FSCMD $FSARG $IMG
## Send it using pushbullet
$PBCMD push all file $IMG
