from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

users = Blueprint('users', __name__)

@users.route('/usernames', methods=['GET'])
def get_usernames():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """SELECT user_id, CONCAT(first_name, ' ', last_name) as full_name FROM users"""
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    usernames = [{"user_id": row[0], "full_name": row[1]} for row in theData]
    return jsonify(usernames)

