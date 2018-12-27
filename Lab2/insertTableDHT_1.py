
import sqlite3 as lite
import sys
con=lite.connect('SensorsData.db')
with con:
	cur=con.cursor()
	cur.execute("INSERT INTO DHT_data VALUES(datetime('now'), 20.5,30)")
	cur.execute("INSERT INTO DHT_data VALUES(datetime('now'), 28.5,40)")
	cur.execute("INSERT INTO DHT_data VALUES(datetime('now'), 30.5,50)")
