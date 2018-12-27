''' 
Michael Towns
Chris Sanders
'''

import RPi.GPIO as GPIO
import dht11
import time
import sqlite3
import sys
# initialize GPIO
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.cleanup
# set defaults
sampleFreq = 5 # time in seconds
pin=17
# fectch sensor readings
def getDHTdata():
    instance= dht11.DHT11(pin)
    result=instance.read()
    hum= result.humidity
    temp = result.temperature
    if hum is not None and temp is not None:
        hum = round(hum)
        temp = round(temp, 1)
        if hum >1 and temp >1:
            logData(temp, hum)
# log sensor data into database
def logData(temp, hum):
    conn=sqlite3.connect('SensorsData.db')
    curs=conn.cursor()
    curs.execute("INSERT INTO DHT_data values(datetime('now'), (?), (?))", (temp, hum))
    conn.commit()
    conn.close()
# display contents of data
def displayData():
    conn=sqlite3.connect('SensorsData.db')
    curs=conn.cursor()
    print ("\n Entire database contents: \n")
    for row in curs.execute("SELECT * FROM DHT_data"):
        print(row)
    conn.close()
# main function
def main():
    '''for i in range(0,3):
        getDHTdata()
        time.sleep(sampleFreq)'''
    while(True):
        getDHTdata()
        time.sleep(sampleFreq)
        displayData()
# Execute Program
main()
