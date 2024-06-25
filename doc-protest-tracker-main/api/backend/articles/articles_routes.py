from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
import logging

logger = logging.getLogger()


articles = Blueprint('articles', __name__)


# gets all of the articles from the database
@articles.route('/all', methods=['GET'])
def get_articles():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """
        SELECT article_name, author_first_name, author_last_name, publication_date, source FROM news_articles
        """
    filters = []

     # Apply filters
    if 'published_date' in request.args:
        filters.append(f"publication_date >= '{request.args['published_date']}'")
    if 'sources' in request.args:
        sources = request.args.getlist('sources')
        sources_string = ["\"" + source + "\"" for source in sources]
        sources_filter = ', '.join(sources_string)
        filters.append(f"source IN ({sources_filter})")

    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

    query += ' order by publication_date desc'

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
    return the_response # returns it back through the rest api 

# get all of the sources from the database
@articles.route('/sources', methods=['GET'])
def get_sources():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """
        SELECT DISTINCT source FROM news_articles
        """
    current_app.logger.info(query)
    cursor.execute(query)

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()
    logger.info(f'the Data: {theData}')

    # for each of the rows, zip the data elements together with
    # the column headers. 
    sources = [element for inner_tuple in theData for element in inner_tuple]
    json_data = {"source_names": sources}

    return jsonify(json_data)
