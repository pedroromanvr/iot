import RPi.GPIO as GPIO
import time
import subprocess
 
sensor = 7 #your GPIO on RPI
GPIO.setmode(GPIO.BCM)
GPIO.setup(sensor, GPIO.IN, GPIO.PUD_DOWN)
 
current_state = False
 
while True:
    time.sleep(1) #allow to set
    current_state = GPIO.input(sensor)
    if current_state == 0:
        print 'no movement'
    else:   
        print 'You are moving'
        subprocess.Popen("/home/pi/pTests/iot/bin/tnspic.sh")
        time.sleep(20) # No need to take a lot of pictures
