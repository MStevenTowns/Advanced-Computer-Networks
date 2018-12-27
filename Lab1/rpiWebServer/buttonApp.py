'''
	Raspberry Pi GPIO Status and Control
'''
import RPi.GPIO as GPIO
from flask import Flask, render_template

app = Flask(__name__)

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

#p0 is on top, number 17
button = 17

buttonSts = GPIO.LOW
   
# Set button pin as an input
GPIO.setup(button, GPIO.IN)   
	
@app.route("/")
def index():
	# Read Sensor Status
	buttonSts = GPIO.input(button)

	templateData = {
      'title' : 'GPIO Input Status!',
      'button'  : buttonSts
      }
	return render_template('index.html', **templateData)

if __name__ == "__main__":
   app.run(host='0.0.0.0', port=80, debug=True)
