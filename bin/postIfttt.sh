#!/bin/bash
#
# Usage is:
# postIfttt.sh <trigger> <value1> [<value2> [<value3>]]
#
#
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80
TRIGGER=$1
VALUE1=$2
VALUE2=$3
VALUE3=$4
KEY="dRIBtBEwTfdfOmWEd8Rrb8ZW2PefFdbtWra1Ifa7SCm"
URL="https://maker.ifttt.com/trigger/$TRIGGER/with/key/$KEY"
CURL_BIN="/usr/bin/curl"
CURL_ARGS="--request POST --header \"Content-Type: application/json\""
CURL_DATA=$(printf "%s \'{\"value1\":\"%s\",\"value2\":\"%s\",\"value3\":\"%s\"}\'" "--data" "$VALUE1" "$VALUE2" "$VALUE3")
echo $CURL_BIN $CURL_ARGS $CURL_DATA $URL
