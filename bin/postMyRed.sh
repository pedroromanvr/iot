#!/bin/bash
#
# Usage is:
# postIfttt.sh <value1> [<value2> [<value3>]]
#
#
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80
VALUE1=$1
KEY="dRIBtBEwTfdfOmWEd8Rrb8ZW2PefFdbtWra1Ifa7SCm"
#URL="http://ec2-54-89-176-127.compute-1.amazonaws.com"
URL="54.89.176.127"
CURL_BIN="/usr/bin/curl"
CURL_ARGS="--request POST --header \"Content-Type: application/json\""
CURL_DATA=$(printf "%s \'{\"value1\":\"%s\"}\'" "--data" "$VALUE1" )
echo $CURL_BIN $CURL_ARGS $CURL_DATA $URL
