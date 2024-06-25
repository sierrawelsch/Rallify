########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
from backend.model2.model2_functions import predict
import logging
logger = logging.getLogger()

model2 = Blueprint('model2', __name__)

@model2.route('/model2/<var01>/<var02>/<var03>', methods=['GET'])
def predicting_amount_of_protests(var01, var02, var03):
    current_app.logger.info(f'var01 = {var01}')
    current_app.logger.info(f'var02 = {var02}')
    current_app.logger.info(f'var03 = {var03}')

    prediction = predict(var01, var02, var03)
    #print(prediction)
    return_dict = {'prediction_value': prediction}
    #current_app.logger.info(f'hello = {return_dict}')
    the_response = make_response(jsonify(return_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response