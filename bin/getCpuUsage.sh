#!/bin/bash
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80

# vmstat with 2 second stadistics time, pick 2nd row because
# first row will return the values from boot.
VAR="id"
VMSTATCMD="/usr/bin/vmstat 2 2" 

# Get idle and then return "100 - idle"
$VMSTATCMD | awk -v col="$VAR" '
    NR==2 {for (i=1; i<=NF; i++) if ($i == col) break}
    NR==4 {print 100 - $i}
'
