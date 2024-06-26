from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

causes = Blueprint('causes', __name__)

@causes.route('/cause', methods=['GET'])
def get_cause():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT cause_id, cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@causes.route('/addcause', methods=['POST'])
def add_cause():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    cause_names = [row[0] for row in theData]
    return jsonify(cause_names)