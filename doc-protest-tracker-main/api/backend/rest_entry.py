import logging
import os
logging.basicConfig(level=logging.DEBUG)

from flask import Flask

from backend.db_connection import db

from backend.countries.countries_routes import countries
from backend.posts.posts_routes import posts
from backend.protests.protests_routes import protests
from backend.cause.cause_routes import causes
from backend.model1.model1_routes import model1
from backend.users.users_routes import users
from backend.model2.model2_routes import model2
from backend.articles.articles_routes import articles

import os
from dotenv import load_dotenv
from flask import Flask

logging.basicConfig(level=logging.DEBUG)


def create_app():
    app = Flask(__name__)

    # Load environment variables
    load_dotenv()
    testvar = os.getenv("TEST_VAR")
    app.logger.info(f"testvar is {testvar}")

    # secret key that will be used for securely signing the session
    # cookie and can be used for any other security related needs by
    # extensions or your application
    # app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    # # these are for the DB object to be able to connect to MySQL.
    # app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config["MYSQL_DATABASE_USER"] = os.getenv("DB_USER")
    app.config["MYSQL_DATABASE_PASSWORD"] = os.getenv("MYSQL_ROOT_PASSWORD")
    app.config["MYSQL_DATABASE_HOST"] = os.getenv("DB_HOST")
    app.config["MYSQL_DATABASE_PORT"] = int(os.getenv("DB_PORT"))
    app.config["MYSQL_DATABASE_DB"] = os.getenv(
        "DB_NAME"
    )  # Change this to your DB name

    # Initialize the database object with the settings above.
    db.init_app(app)

    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    app.logger.info("current_app(): registering blueprints with app object.")

    app.register_blueprint(countries,   url_prefix='/cntry')
    app.register_blueprint(posts ,      url_prefix='/psts')
    app.register_blueprint(protests,   url_prefix='/prtsts')
    app.register_blueprint(causes,      url_prefix='/cause')
    app.register_blueprint(model1,     url_prefix='/model1')
    app.register_blueprint(model2,     url_prefix='/model2')
    app.register_blueprint(users,      url_prefix='/users')
    app.register_blueprint(articles,   url_prefix='/articles')

    return app
