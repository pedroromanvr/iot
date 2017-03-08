#!/bin/bash
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80

CMD="/usr/bin/free -k"  # print in Kb

# Get idle and then return "used/total"
$CMD | grep Mem |  awk '{printf "%2.1f\n",$3/$2*100.0}'
