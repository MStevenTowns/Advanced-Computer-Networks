from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure 
import io

from flask import Flask, render_template, send_file, make_response, request
app = Flask(__name__)

import sqlite3
conn=sqlite3.connect('../SensorsData.db')
curs=conn.cursor()

# Get sample frequency in minutes
def freqSample():
	times,temps,hums = geetHistData(2)
	fmt = '%Y-%m-%d %H:%M:%S'
	tsttamp0 = datetime.strptime(times[0], fmt)
	tsttamp1 = datetime.strptime(times[1], fmt)
	freq = tstamp1-timestamp0
	freq = int(round(freq.total_seconds()/60))
	return(freq) 

# Retrieve LAST data from database
def getData():
	for row in curs.execute("SELECT * FROM DHT_data ORDER BY timestamp DESC LIMIT 1"):
		time = str(row[0])
		temp = row[1]
		hum = row[2]
	return time, temp, hum
	
def getHistData (numSamples):
	curs.execute("SELECT * FROM DHT_data ORDER BY timestamp DESC LIMIT " + str(numSamples))
	data = curs.fetchall()
	dates = []
	temps = []
	hums = []
	for row in reversed(data):
		dates.append(row[0])
		temps.append(row[1])
		hums.append(row[2])
		temps, hums = testeData(temps, hums)
	return dates,temps,hums

# Test data for cleaning possible "out of range" values
def testeData(temps, hums):
	n = len(temps)
	for i in range(0, n-1):
		if (temps[i] <= 0 or temps[i] >= 50):
			temps[i] = temps[i-2]
		if (hums[i] <= 0 or hums[i] >100):
			hums[i] = hums[i-2]
	return temps, hums

def maxRowsTable():
	for row in curs.execute("SELECT COUNT(temp) from DHT_data"):
		maxNumberRows=row[0]
	return maxNumberRows

# define and initialize global variables
global numSamples
numSamples = maxRowsTable()
if(numSamples > 101):
	numSamples = 100

# main route
@app.route("/")
def index():
	time, temp, hum = getData()
	templateData = {
		'time' : time,
		'temp' : temp,
		'hum' : hum,
		'numSamples' : numSamples
	}
	return render_template('index.html', **templateData)
	
@app.route('/', methods=['POST'])
def my_form_post():
	global numSamples
	global freqSamples
	global rangeTime
	rangeTime = int(request.form['rangeTime'])
	if(rangeTime < freqSamples):
		rangeTime = freqSamples + 1
	numSamples = rangeTime // freqSamples
	numMaxSamples = maxRowsTable()
	if (numSamples > numMaxSamples):
		numSamples = (numMaxSamples-1)
	numSamples=numMaxSamples
	#comments start here
	'''	
	 numSamples = int(request.form['numSamples'])
	numMaxSamples = maxRowsTable()
	if(numSamples > numMaxSamples):
		numSamples = (numMaxSamples-1)
	time,temp,hum = getLastData()
	templateData = {
		'time' : time,
		'temp' : temp,
		'hum' : hum,
		'numSamples' : numSamples
		}
	return render_template('index.html', **templateData) '''
	

@app.route('/plot/temp')
def plot_temp():
	times, temps, hums = getHistData(numSamples)
	ys = temps
	fig = Figure()
	axis = fig.add_subplot(1,1,1)
	axis.set_title("Temperature [degree Celcius]")
	axis.set_xlabel("Samples")
	axis.grid(True)
	xs = range(numSamples)
	axis.plot(xs, ys)
	canvas = FigureCanvas(fig)
	output = io.BytesIO()
	canvas.print_png(output)
	response = make_response(output.getvalue())
	response.mimetype = 'image/png'
	return response

@app.route('/plot/hum')
def plot_hum():
	times, temps, hums = getHistData(numSamples)
	ys = hums
	fig = Figure()
	axis = fig.add_subplot(1,1,1)
	axis.set_title("Humidity [%]")
	axis.set_xlabel("Samples")
	axis.grid(True)
	xs = range(numSamples)
	axis.plot(xs, ys)
	canvas = FigureCanvas(fig)
	output = io.BytesIO()
	canvas.print_png(output)
	response = make_response(output.getvalue())
	response.mimetype = 'image/png'
	return response
	

if __name__ == "__main__":
	app.run(host = '0.0.0.0', port=80, debug = False)
	
