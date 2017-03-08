#!/bin/bash
export HTTPS_PROXY=http://www-proxy.us.oracle.com:80
export HTTP_PROXY=http://www-proxy.us.oracle.com:80

CMD="/opt/vc/bin/vcgencmd measure_temp" # Get the temperature

$CMD | grep -o '[0-9.]*' #Get only numbers
