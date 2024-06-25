import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests
import plotly.express as px
import pandas as pd

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting Similar Countries')

# writes a description of the model
st.write('Enter the GDP per Capita and Protests per 100,000 to predict the k-means cluster for each country. The countries in the database are clustered based on these two features. The model will predict the cluster for the input values and display the countries in each cluster.')
gdp_per_capita = st.slider('GDP per Capita:', 0, 200000, 10000)

# makes protests per capita a slider from 0 to 200 with a default value of 50
protests_per_100000 = st.slider('Protests per 100,000 people:', 0, 200, 50)

# max number of clusters is 10, number input
n_clusters = st.number_input('Number of Clusters:', min_value=0, max_value=10, value=3)

# Make a predict button that sends the input values to the REST API
if st.button('Predict Clusters', type='primary', use_container_width=True):
    response = requests.get(f'http://api:4000/model2/model2/{gdp_per_capita}/{protests_per_100000}/{n_clusters}')
    
    if response.status_code == 200:
        results = response.json()
        logger.info(f"Response: {results}")

        # Extract prediction results
        clusters = results['prediction_value'][0]
        predicted_cluster = results['prediction_value'][1]
        df_country = results['prediction_value'][2]
                
        # Get the countries into n lists based on the cluster number
        cluster_data = []
        for cluster in clusters:
            cluster_list = clusters[cluster]
            cluster_data.append({'Cluster': cluster, 'Countries': ', '.join(cluster_list)})

        # Display the countries in each cluster as a table
        st.write('### Cluster Information:')
        st.write('The countries in each cluster are displayed below.')
        st.table(pd.DataFrame(cluster_data))
        
        # Transform the list of lists into a DataFrame to be displayed
        cluster_data = []
        for cluster_num, cluster in clusters.items():  # Iterate over keys and values
            for country in cluster:
                cluster_data.append({'country': country, 'cluster': int(cluster_num)}) 
        df = pd.DataFrame(cluster_data)

        # Create a choropleth map
        fig = px.choropleth(df, locations='country',
                            locationmode='country names',
                            color='cluster',
                            hover_name='country',
                            title='Cluster Prediction Results',
                            color_continuous_scale=px.colors.sequential.Plasma)

        fig.update_layout(height=600, width=800, margin=dict(l=20, r=20, t=30, b=20))
        st.plotly_chart(fig)

        # make the colors more distinct
        st.write('### Cluster Visualization with Distinct Colors:')
        st.write('The plot below shows the clusters based on the input data.')
        fig = px.scatter(df_country, x='gdp_per_capita', y='protests_per_capita', color='cluster', title='Cluster Visualization with Distinct Colors')
        fig.update_traces(marker=dict(size=12, line=dict(width=2, color='DarkSlateGrey')), selector=dict(mode='markers'))
        
        # also plots the input data
        fig.add_trace(px.scatter(x=[gdp_per_capita], y=[protests_per_100000], color=['Input Data']).data[0])
        st.plotly_chart(fig)

        st.write('### Predicted Cluster:')
        st.write('Your input data is predicted to belong to cluster', str(predicted_cluster), '.')
    else:
        st.error('Failed to get prediction. Please try again.')