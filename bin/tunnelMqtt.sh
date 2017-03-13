#!/bin/bash

# This service allows a remote tunneling over http using ssh
# Primary use is to tunnel mqtt traffic over http
# corkscrew is used to make the http clientside tunneling http://www.agroman.net/corkscrew/
# command to execute is:
# ssh -i PInstance.pem ec2-user@ec2-54-89-176-127.compute-1.amazonaws.com -L 1883:ec2-54-89-176-127.compute-1.amazonaws.com:1883 -N -o "ProxyCommand /home/pi/corkscrew/corkscrew-2.0/corkscrew www-proxy.us.oracle.com 80 ec2-54-89-176-127.compute-1.amazonaws.com 22"
export https_proxy=http://www-proxy.us.oracle.com:80;
export http_proxy=http://www-proxy.us.oracle.com:80;

SSH_CMD="/usr/bin/ssh"
KEY_LOC="/home/pi/corkscrew/PInstance.pem"
USR="ec2-user"
REM_SERV="ec2-54-89-176-127.compute-1.amazonaws.com"
CORK_LOC="/home/pi/corkscrew/corkscrew-2.0/corkscrew"
PROX="www-proxy.us.oracle.com"
PORT="80"
SSH_PORT="22"
MQTT_PORT="1883"

P_CMD="\"ProxyCommand $CORK_LOC $PROX $PORT $REM_SERV $SSH_PORT\""
KEY_ARGS="-i $KEY_LOC"
FWD_ARGS="-L $MQTT_PORT:$REM_SERV:$MQTT_PORT"
NOP_ARGS="-N"
OPT_ARGS="-o $P_CMD"
bash -c "$SSH_CMD $KEY_ARGS $USR@$REM_SERV $FWD_ARGS $NOP_ARGS $OPT_ARGS"
