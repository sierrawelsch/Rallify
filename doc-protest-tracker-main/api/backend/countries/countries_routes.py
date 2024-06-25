from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

countries = Blueprint('countries', __name__)

@countries.route('/countries', methods=['GET'])
def get_countries():
    cursor = db.get_db().cursor()

    # Base query
    query = '''SELECT country, protests_per_capita, population, gdp_per_capita,
               unemployment_rate, urbanization_rate, inflation_rate
               FROM country'''
    current_app.logger.info("Base query: %s", query)

    filters = []
    params = []

    # Get filter parameters from request
    region = request.args.get('region')
    protests_per_capita_min = request.args.get('protests_per_capita_min')
    protests_per_capita_max = request.args.get('protests_per_capita_max')
    population_min = request.args.get('population_min')
    population_max = request.args.get('population_max')
    gdp_per_capita_min = request.args.get('gdp_per_capita_min')
    gdp_per_capita_max = request.args.get('gdp_per_capita_max')
    unemployment_rate_min = request.args.get('unemployment_rate_min')
    unemployment_rate_max = request.args.get('unemployment_rate_max')
    urbanization_rate_min = request.args.get('urbanization_rate_min')
    urbanization_rate_max = request.args.get('urbanization_rate_max')
    inflation_rate_min = request.args.get('inflation_rate_min')
    inflation_rate_max = request.args.get('inflation_rate_max')

    # Add filters to the query if they are provided
    if region:
        filters.append("region = %s")
        params.append(region)
    if protests_per_capita_min:
        filters.append("protests_per_capita >= %s")
        params.append(protests_per_capita_min)
    if protests_per_capita_max:
        filters.append("protests_per_capita <= %s")
        params.append(protests_per_capita_max)
    if population_min:
        filters.append("population >= %s")
        params.append(population_min)
    if population_max:
        filters.append("population <= %s")
        params.append(population_max)
    if gdp_per_capita_min:
        filters.append("gdp_per_capita >= %s")
        params.append(gdp_per_capita_min)
    if gdp_per_capita_max:
        filters.append("gdp_per_capita <= %s")
        params.append(gdp_per_capita_max)
    if unemployment_rate_min:
        filters.append("unemployment_rate >= %s")
        params.append(unemployment_rate_min)
    if unemployment_rate_max:
        filters.append("unemployment_rate <= %s")
        params.append(unemployment_rate_max)
    if urbanization_rate_min:
        filters.append("urbanization_rate >= %s")
        params.append(urbanization_rate_min)
    if urbanization_rate_max:
        filters.append("urbanization_rate <= %s")
        params.append(urbanization_rate_max)
    if inflation_rate_min:
        filters.append("inflation_rate >= %s")
        params.append(inflation_rate_min)
    if inflation_rate_max:
        filters.append("inflation_rate <= %s")
        params.append(inflation_rate_max)

    # Combine base query with filters if any
    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

    current_app.logger.info("Final query: %s", query)
    current_app.logger.info("Parameters: %s", params)

    cursor.execute(query, params)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@countries.route('/names', methods=['GET'])
def get_country_names():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT country FROM country'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    country_names = [row[0] for row in theData]
    return jsonify(country_names)

# route for getting just one country
@countries.route('/country/<country>', methods=['GET'])
def get_country_detail(country):
    # Parameterized query to prevent SQL injection
    query = ('SELECT country, protests_per_capita, population, gdp_per_capita, '
             'unemployment_rate, urbanization_rate, inflation_rate '
             'FROM country WHERE country = %s')

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query, (country,))
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    # Check if any data is found
    if not json_data:
        return jsonify({"error": "Country not found"}), 404

    return jsonify(json_data)

