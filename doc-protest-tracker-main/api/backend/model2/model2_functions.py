import numpy as np 
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
from backend.db_connection import db
from flask import jsonify
import logging
from sklearn.cluster import KMeans

logger = logging.getLogger()

def initialize():
    cursor = db.get_db().cursor()
    # gets the country data from the database
    query = 'SELECT * FROM country'
    cursor.execute(query)
    data = cursor.fetchall()
    # get the column names
    column_names = [x[0] for x in cursor.description]
    df_country = pd.DataFrame.from_records(data, columns=column_names)
    logger.info(f"coefficients: {df_country}")
    return df_country


# Takes in protests per capita and gdp per capita, and returns the list of clusters with country names and the cluster the input data belongs to
def predict(protests_per_capita, gdp_per_capita, n_clusters):
    df_country = initialize()

    # Ensure column names match exactly
    df_country.rename(columns=lambda x: x.strip(), inplace=True)
    # turn n_clusters into an integer
    n_clusters = int(n_clusters)
    kmeans = KMeans(n_clusters=n_clusters, n_init=10)  # Set n_init explicitly
    X = df_country[['protests_per_capita', 'gdp_per_capita']]

    # Normalizing features
    X = (X - X.mean()) / X.std()
    kmeans.fit(X)
    
    # Get the cluster labels for all data points
    df_country['cluster'] = kmeans.labels_
    
    # Create a dictionary to hold clusters and associated countries
    clusters = {}
    for cluster_num in range(n_clusters):
        clusters[cluster_num] = df_country[df_country['cluster'] == cluster_num]['country'].tolist()
           
    # Create a DataFrame for the input to maintain feature names
    input_data = pd.DataFrame([[protests_per_capita, gdp_per_capita]], columns=['protests_per_capita', 'gdp_per_capita'])
    
    # Predict the cluster for the input data
    input_cluster = kmeans.predict(input_data)[0]
    
    input_cluster = int(input_cluster)
    
    # make df_country json serializable
    df_country = df_country.to_dict()
    
    return clusters, input_cluster, df_country