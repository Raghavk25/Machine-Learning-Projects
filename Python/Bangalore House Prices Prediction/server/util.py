import json
import pickle
import numpy as np

__locations = None
__data_columns = None
__model = None

def load_saved_artifacts():
    global __data_columns
    global __locations
    global __model

    with open('ML projects//BHP//server//artifacts//columns.json', 'r') as f:
        __data_columns = json.load(f)['data_columns']
        __locations = __data_columns[3:]

    with open('ML projects//BHP//server//artifacts//Bangalore_house_prices_model.pkl', 'rb') as f:
        __model = pickle.load(f)

def get_location_names():
    load_saved_artifacts()
    return __locations

def get_estimated_price(location, total_sqft, bath, bhk):
    try:
        loc_index = __data_columns.index(location.lower())
    except:
        loc_index = -1
    x = np.zeros(len(__data_columns))
    x[0] = total_sqft
    x[1] = bath
    x[2] = bhk
    if loc_index >= 0:
        x[loc_index] = 1
    return round(__model.predict([x])[0], 2)

if __name__ == "__main__":
    load_saved_artifacts()

    
