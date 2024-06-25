########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
from backend.model1.model1_functions import predict
from backend.model1.model1_functions import initialize
from backend.model1.model1_functions import generate_activity_level
import logging
logger = logging.getLogger()

model1 = Blueprint('model1', __name__)

# Get all customers from the DB
@model1.route('/model1/<var01>/<var02>/<var03>/<var04>', methods=['GET'])
def predicting_amount_of_protests(var01, var02, var03, var04):
    current_app.logger.info(f'var02 = {var02}')
    current_app.logger.info(f'var03 = {var03}')
    current_app.logger.info(f'var04 = {var04}')

    prediction = predict(var01, var02, var03, var04)
    #print(prediction)
    return_dict = {'prediction_value': prediction}
    #current_app.logger.info(f'hello = {return_dict}')
    the_response = make_response(jsonify(return_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response

# Get the line of best fit
@model1.route('/lobf', methods=['GET'])
def get_lobf():
    lobf = initialize()
    lobf_dict = {}
    lobf_dict = {
    "beta_0" : lobf[0],
    "beta_1" : lobf[1],
    "beta_2" : lobf[2],
    "beta_3" : lobf[3],
    "beta_4" : lobf[4],
    "beta_5" : lobf[5],
    "beta_6" : lobf[6],
    "beta_7" : lobf[7],
    "beta_8" : lobf[8],
    "beta_9" : lobf[9],
    "beta_10" : lobf[10],
    "beta_11" : lobf[11],
    "beta_12" : lobf[12],
    "beta_13" : lobf[13],
    "beta_14" : lobf[14],
    "beta_15" : lobf[15],
    "beta_16" : lobf[16],
    "beta_17" : lobf[17],
    "beta_18" : lobf[18],
    "beta_19" : lobf[19],
    "beta_20" : lobf[20],
    "beta_21" : lobf[21],
    "beta_22" : lobf[22]
    }
    #current_app.logger.info(f'hello = {return_dict}')
    the_response = make_response(jsonify(lobf_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response


# POST a new product
@model1.route('/insert-params', methods=['POST'])
def insert_coefficients():
      # collecting data from the request object 
    data = request.json
    logger.info(f"Responseeee: {data}")

    beta_0 = data['beta_0']
    beta_1 = data['beta_1']
    beta_2 = data['beta_2']
    beta_3 = data['beta_3']
    beta_4 = data['beta_4']
    beta_5 = data['beta_5']
    beta_6 = data['beta_6']
    beta_7 = data['beta_7']
    beta_8 = data['beta_8']
    beta_9 = data['beta_9']
    beta_10 = data['beta_10']
    beta_11 = data['beta_11']
    beta_12 = data['beta_12']
    beta_13 = data['beta_13']
    beta_14 = data['beta_14']
    beta_15 = data['beta_15']
    beta_16 = data['beta_16']
    beta_17 = data['beta_17']
    beta_18 = data['beta_18']
    beta_19 = data['beta_19']
    beta_20 = data['beta_20']
    beta_21 = data['beta_21']
    beta_22 = data['beta_22']



    # Construct the query
    query = 'INSERT INTO model1_lobf_coefficients (beta_0, beta_1, beta_2, beta_3, beta_4, beta_5, beta_6, beta_7, beta_8, beta_9, beta_10, beta_11, beta_12, beta_13, beta_14, beta_15, beta_16, beta_17, beta_18, beta_19, beta_20, beta_21, beta_22) VALUES ('
    query += "'" + str(beta_0) + "',"
    query += "'" + str(beta_1) + "',"
    query += "'" + str(beta_2) + "',"
    query += "'" + str(beta_3) + "',"
    query += "'" + str(beta_4) + "',"
    query += "'" + str(beta_5) + "',"
    query += "'" + str(beta_6) + "',"
    query += "'" + str(beta_7) + "',"
    query += "'" + str(beta_8) + "',"
    query += "'" + str(beta_9) + "',"
    query += "'" + str(beta_10) + "',"
    query += "'" + str(beta_11) + "',"
    query += "'" + str(beta_12) + "',"
    query += "'" + str(beta_13) + "',"
    query += "'" + str(beta_14) + "',"
    query += "'" + str(beta_15) + "',"
    query += "'" + str(beta_16) + "',"
    query += "'" + str(beta_17) + "',"
    query += "'" + str(beta_18) + "',"
    query += "'" + str(beta_19) + "',"
    query += "'" + str(beta_20) + "',"
    query += "'" + str(beta_21) + "',"
    query += "'" + str(beta_22) + "')"
   
    
    print(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"

# Get all customers from the DB
@model1.route('/activity-level/<pred_per_capita>', methods=['GET'])
def get_activity_level(pred_per_capita):
    current_app.logger.info(f'pred_per_capita = {pred_per_capita}')

    activity_level = generate_activity_level(pred_per_capita)
    #print(prediction)
    return_dict = {'activity_level': activity_level}
    #current_app.logger.info(f'hello = {return_dict}')
    the_response = make_response(jsonify(return_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response