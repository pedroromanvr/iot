#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Test publishing device data via MQTT to relayr cloud.

This subscribes to a given MQTT topic and publishes messages
for this topic, so it receives the same messages previously
posted.

This code needs the paho-mqtt package to be installed, e.g.
with "pip install paho-mqtt>=1.1".
"""

import json
import time
import paho.mqtt.client as mqtt
"Imports related to ds18b20 sensor connected in GPIO 4 using 1-wire interface"
import os
import glob
import time


base_dir = '/sys/bus/w1/devices/'
device_folder = glob.glob(base_dir + '28*')[0]
device_file = device_folder + '/w1_slave'

# mqtt credentials
creds = {
    'clientId': 'TGBB4+35TTV2boMXz9cD8MA',
    'user':     '181078fb-7e53-4d5d-9ba0-c5f3f5c0fc30',
    'password': '0AJjupkUkvg8',
    'topic':    '/v1/181078fb-7e53-4d5d-9ba0-c5f3f5c0fc30/',
    'server':   'mqtt.relayr.io',
    'port':     1883
}

# ATTENTION !!!
# DO NOT try to set values under 200 ms of the server
# will kick you out
publishing_period = 1000


class MqttDelegate(object):
    "A delegate class providing callbacks for an MQTT client."

    def __init__(self, client, credentials):
        self.client = client
        self.credentials = credentials

    def on_connect(self, client, userdata, flags, rc):
        print('Connected.')
        # self.client.subscribe(self.credentials['topic'].encode('utf-8'))
        self.client.subscribe(self.credentials['topic'] + 'cmd')

    def on_message(self, client, userdata, msg):
        print('Command received: %s' % msg.payload)

    def on_publish(self, client, userdata, mid):
        print('Message published.')

def read_temp_raw():
    f = open(device_file, 'r')
    lines = f.readlines()
    f.close()
    return lines

def read_temp():
    lines = read_temp_raw()
    while lines[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines = read_temp_raw()
    equals_pos = lines[1].find('t=')
    if equals_pos != -1:
        temp_string = lines[1][equals_pos+2:]
        temp_c = float(temp_string) / 1000.0
        temp_f = temp_c * 9.0 / 5.0 + 32.0
        return temp_c, temp_f

def init_ds18b20():
    os.system('modprobe w1-gpio')
    os.system('modprobe w1-therm')
    return

def main(credentials, publishing_period):
    init_ds18b20()
    client = mqtt.Client(client_id=credentials['clientId'])
    delegate = MqttDelegate(client, creds)
    client.on_connect = delegate.on_connect
    client.on_message = delegate.on_message
    client.on_publish = delegate.on_publish
    user, password = credentials['user'], credentials['password']
    client.username_pw_set(user, password)
    # client.tls_set(cafile)
    # client.tls_insecure_set(False)
    try:
        print('Connecting to mqtt server.')
        server, port = credentials['server'], credentials['port']
        client.connect(server, port=port, keepalive=60)
    except:
        print('Connection failed, check your credentials!')
        return

    # set 200 ms as minimum publishing period
    if publishing_period < 200:
        publishing_period = 200

    while True:
        client.loop()
        temp_c, temp_f = read_temp()
        # publish data
        message = {
            'meaning': 'temp_dht',
            'value': temp_c
        }
        client.publish(credentials['topic'] +'data', json.dumps(message))

        time.sleep(publishing_period / 1000.)


if __name__ == '__main__':
    main(creds, publishing_period)
