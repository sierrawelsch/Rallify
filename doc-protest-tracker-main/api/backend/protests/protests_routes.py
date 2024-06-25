from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db


protests = Blueprint('protests', __name__)

# Get all the protests from the data base
@protests.route('/protests', methods=['GET'])
def get_protests():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """
        SELECT created_by, protest_id, cause_name, date, location, protests.country, description, violent, 
        CONCAT(first_name, ' ', last_name) as full_name,
        longitude, latitude
        FROM protests
            JOIN cause on protests.cause = cause.cause_id
            LEFT JOIN users on protests.created_by = users.user_id
            JOIN country on protests.country = country.country
    
        """
    filters = []

        # Apply filters
    if 'date' in request.args:
        filters.append(f"date >= '{request.args['date']}'")
    if 'cause' in request.args:
        causes = request.args.getlist('cause')
        cause_filter = ', '.join(causes)
        filters.append(f"cause IN ({cause_filter})")
    if 'created_by' in request.args:
        usernames = request.args.getlist('created_by')
        user_filter = ', '.join(usernames)
        filters.append(f"created_by IN ({user_filter})")
    if 'protests.country' in request.args:
        countries = request.args.getlist('protests.country')
        countries_string = ["\"" + country + "\"" for country in countries]
        country_filter = ', '.join(countries_string)
        filters.append(f"country.country IN ({country_filter})")

    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

    query += ' order by date desc'

    current_app.logger.info(f'Query: {query}')

    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    data = cursor.fetchall() # give back all the date from the sql statement
    json_data = []
    for row in data:
        json_data.append(dict(zip(row_headers, row))) # attribute name, attribute value, etc
    the_response = make_response(jsonify(json_data)) # turns dictionary into json and makes a response object
    the_response.status_code = 200
    the_response.mimetype = 'application/json' # what tyoe of data are we sending back
    return the_response # returns it back through the rest api stuff

# Add a protest
@protests.route('/addprotest', methods=['POST'])
def add_protest():
      # collecting data from the request object 
    data = request.json

    location = data['location']
    date = data['date']
    description = data['description']
    created_by = data['user_id']
    country = data['country']
    cause = data['cause']
    longitude = "1.1"
    latitude = "2.1"
    # Construct the query
    query = 'INSERT INTO protests (location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('
    query += "'" + location + "',"
    query += "'" + date + "',"
    query += "'" + description + "',"
    query += "'" + str(created_by) + "',"
    query += "'" + country + "',"
    query += "'" + str(cause) + "',"
    query += "'" + str(longitude)+ "',"
    query += "'" + str(latitude) + "')"
    
    print(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"



# UPDATE a post
@protests.route('/protest', methods = ['PUT'])
def update_protest():
   try:
        connection = db.get_db()
        cursor = connection.cursor()

        the_data = request.json
        protest_id = the_data['protest_id']
        location = the_data['location']
        description = the_data['description']
        cause = the_data['cause']
        country = the_data['country']
      

        query = 'UPDATE protests SET location = %s, description = %s, cause = %s, country = %s WHERE protest_id = %s'
        
        current_app.logger.info(f'Updating protest with protest_id: {protest_id}')
        cursor.execute(query, (location, description, cause, country, protest_id))
        connection.commit()

        if cursor.rowcount == 0:
            return make_response(jsonify({"error": "Protest not found"}), 404)

        return make_response(jsonify({"message": "Post updated successfully"}), 200)
   except Error as e:
        current_app.logger.error(f"Error updating protest with protest_id: {protest_id}, error: {e}")
        return make_response(jsonify({"error": "Internal server error"}), 500)
   finally:
        if cursor:
            cursor.close()

# DELETE a post
@protests.route('/protest/<int:id>', methods=['DELETE'])
def delete_protest(id):
    cursor = db.get_db().cursor()

    # Constructing the query to delete the post by id
    query = 'DELETE FROM protests WHERE protest_id = %s'
    
    current_app.logger.info(f'Deleting protest with id: {id}')
    cursor.execute(query, (id,))
    db.get_db().commit()
    
    if cursor.rowcount == 0:
        return make_response(jsonify({"error": "Protest not found"}), 404)
    
    return jsonify({"message": "Protest deleted successfully"}), 200

# Get a particular user's protests
@protests.route('/myprotests/<user_id>', methods=['GET'])
def get_user_protests(user_id):
    query = ('SELECT cause_name, protest_id, location, date, description, created_by, protests.country, cause, first_name, last_name FROM protests LEFT JOIN users on protests.created_by = users.user_id LEFT JOIN cause on protests.cause = cause.cause_id WHERE user_id = ' + str(user_id))
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    json_data = [dict(zip(column_headers, row)) for row in theData]
    # Check if any data is found
    if not json_data:
        return jsonify({"error": "Protest not found"}), 404

    return jsonify(json_data)


# Get one protest with one protest
@protests.route('/protests/<protest_id>', methods=['GET'])
def get_protest_detail(protest_id):
    query = ("""SELECT protest_id, location, date, description, created_by, protests.country as protest_country, cause, longitude, latitude, cause_id, cause_name, user_id, first_name, last_name, users.country as user_country FROM protests 
             LEFT JOIN cause on protests.cause = cause.cause_id 
             LEFT JOIN users on protests.created_by = users.user_id
             WHERE protest_id = """
              + str(protest_id))
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    current_app.logger.info(f'column_headers = {column_headers}')
    theData = cursor.fetchall()
    current_app.logger.info(f'theData = {theData}')
    json_data = [dict(zip(column_headers, row)) for row in theData]
    # Check if any data is found
    if not json_data:
        return jsonify({"error": "Post not found"}), 404
    return jsonify(json_data)
