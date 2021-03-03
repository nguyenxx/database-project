# Sam Kettlewell-Sites
# HW 5 
from flask import Flask, render_template, redirect, request, flash
import sqlite3

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

@app.route('/')
def index():

    conn = sqlite3.connect('cars.sqlite')
    c = conn.cursor()
    c.execute("SELECT * FROM car")
    car_data = c.fetchall()
    conn.close() 

    return render_template('cars.html', car_info=car_data)

@app.route('/ins', methods=['POST'])
def insert(): 

    data = (request.form["vin"],request.form["make"],request.form["model"],request.form["mile"],
    request.form["price"])

    conn = sqlite3.connect('cars.sqlite')
    c = conn.cursor()
    c.execute("INSERT INTO car VALUES (?,?,?,?,?)", data)
    conn.commit()
    conn.close()

    message = "Sucessfully inserted " + request.form["vin"]

    flash(message)

    return redirect('/')

@app.route('/del/<vin>')
def deleate(vin):

    v_number = (vin,)
    
    conn = sqlite3.connect('cars.sqlite')
    c = conn.cursor()

    c.execute("DELETE FROM car WHERE car.vin = ? ", v_number) 
    conn.commit()
    conn.close()

    message = "You deleted the car with the VIN number " + vin

    flash(message)

    return redirect('/')
    