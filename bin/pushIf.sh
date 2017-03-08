#!/bin/bash
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80
CMD="/home/pi/Downloads/pushbullet-bash/pushbullet"
/sbin/ifconfig | $CMD push all note > /dev/null
