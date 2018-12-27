import sqlite3 as lite
import sys
conn=lite.connect('SensorsData.db')
curs=conn.cursor()

def add_data(temp, hum):
	curs.execute("INSERT INTO DHT_data values(datetime('now'), (?), (?))",(temp,hum))
	conn.commit()
	
add_data(24.5,30)
add_data(34.6, 34)

print("\n Entire database contents: \n")
for row in curs.execute("SELECT * FROM DHT_data"):
	print(row)
	
conn.close()
