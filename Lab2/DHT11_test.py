import RPi.GPIO as GPIO
import dht11
#initialize GPIO
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.cleanup
# Readvalues on pin 
instance = dht11.DHT11(pin=16)
result=instance.read()
humidity = round(result.humidity)
temperature = round(result.temperature,1)
if humidity is not None and temperature is not None:
    print('Temp={}*C Humidity={}%'.format(temperature, humidity))
else:
    print('Failed to get reading. Keep trying!')
