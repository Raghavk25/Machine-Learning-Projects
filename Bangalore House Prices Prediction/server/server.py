from flask import Flask, request, jsonify
import util

app = Flask(__name__)

@app.route('/get_location_names')
def get_location_names():
    response = jsonify({
        'locations': util.get_location_names()
    })
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/predict_home_price', methods = ['POST'])
def predict_home_price():
    total_sqft = float(request.form.get('total_sqft'))
    location = request.form.get('location')
    bath = int(request.form.get('bath'))
    bhk = int(request.form.get('bhk'))
    response = jsonify({
            'estimated_price': util.get_estimated_price(location, total_sqft, bath, bhk) 
    })
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

if __name__ == "__main__":
    app.run()


