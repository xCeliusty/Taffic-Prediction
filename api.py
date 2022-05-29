import os
import json
import pathlib
import logging

from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from flask import Flask, request, render_template
import pandas as pd
import pickle
import numpy as np


app = Flask(__name__)

class NumpyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return json.JSONEncoder.default(self, obj)

le = LabelEncoder()
sc_X = StandardScaler()
with open("svr_model.pkl", 'rb') as pickle_file:
    model = pickle.load(pickle_file)

@app.route('/predict', methods=['GET'])
def my_form_post():
    Date = request.args.get('Date')
    CodedDay = request.args.get('CodedDay')
    Zone = request.args.get('Zone')
    Weather = request.args.get('Weather')
    Temperature = request.args.get('Temperature')
    Rain = request.args.get('Rain')
    Holiday = request.args.get('Holiday')
    Date = le.fit_transform([Date])
    all_features = [[Date, CodedDay, Zone, Weather, Temperature, Rain, Holiday]]
    all_features = sc_X.fit_transform(all_features)
    result = round(model.predict(all_features)[0])
    return json.dumps(
        { "data": 6.94,
        "status": {"code": 1, "message": "success"}},cls=NumpyEncoder)

if __name__ == '__main__':
    app.run(debug = True, port = 9000)


#http://127.0.0.1:9000/predict?Date=02/04/2022&CodedDay=7&Zone=5&Weather=16&Temperature=12.1&Rain=1&Holiday=0