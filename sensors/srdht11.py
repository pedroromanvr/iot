#!/usr/bin/python
import sys
import Adafruit_DHT

humidity, temperature = Adafruit_DHT.read_retry(11, 4)
print '{{"temp":"{0:0.1f}","hum":"{1:0.1f}"}}'.format(temperature, humidity)
