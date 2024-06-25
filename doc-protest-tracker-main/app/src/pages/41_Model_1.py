import logging
logger = logging.getLogger()
import time
import streamlit as st
from modules.nav import SideBarLinks
import requests
import json
import pandas as pd
import numpy as np



lobf_json = requests.get(f'http://api:4000/model1/lobf').json()
logger.info(f'hiii = {lobf_json}')
requests.post(f'http://api:4000/model1/insert-params', json=lobf_json)

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting the Number of Protests in a Specific Region')
#description of what this page is for
st.write('Think of a country you would like to learn more about and input the following information to see how many protests are likely to occur in the country of your choice!')

regions = ["Western", "Asian", "South American"]

# user inputs the country of their choice
country_input = st.text_input('Insert Country Name:')

# user selects the public trust in government percentage
var_01 = st.slider('Select Public Trust in Government (Percentage in Decimal Form):', 0.0, 100.0, 50.0)

# user selects gdp per capita 
var_02 = st.slider('Select GDP per Capita:', 0.0, 200000.0, 50.0)

# user selects the region the country is located in
var_03 = st.selectbox("Select Region:", regions)

# user inputs the population
var_04 = st.number_input('Insert Population:',
                           step=1)

logger.info(f'var_01 = {var_01}')
logger.info(f'var_02 = {var_02}')
logger.info(f'var_03 = {var_03}')
logger.info(f'var_04 = {var_04}')


# prediction function via the REST API
if st.button('Predict Number of Protests',
             type='primary',
             use_container_width=True):
  results = requests.get(f'http://api:4000/model1/model1/{var_01}/{var_02}/{var_03}/{var_04}').json()
  logger.info(f"Response: {results}")
  pred_per_capita = results['prediction_value']
  activity_level = requests.get(f'http://api:4000/model1/activity-level/{pred_per_capita}').json()
  pred = pred_per_capita * var_04 / 100000
  results_display = f'The estimated number of protests that will occur in {country_input} this year will be: {pred}'
  results_per_capita_display = f'The estimated number of protests per 100,000 people that will occur in {country_input} this year will be: {pred_per_capita}'

  background_color = "#f5f5f5"  # Lighter silver

  def stream_data():
    for word in results_display.split(" "):
        yield word + " "
        time.sleep(0.03)
  def stream_data_per_capita():
    for word in results_per_capita_display.split(" "):
        yield word + " "
        time.sleep(0.03)
  st.markdown(f"""
<div style="background-color: {background_color}; font-size: 25px; font-weight: bold;">
  Numeric Prediction:
</div>
""", unsafe_allow_html=True)
  st.write_stream(stream_data)
  st.write_stream(stream_data_per_capita)

  # Define a dictionary mapping text to colors (you can customize this)
  level_to_color = {
      "low": "green",
      "medium": "khaki",
      "high": "red"
  }

  def create_circle_box(text):
    """Creates a Streamlit column with a colored circle and text."""

    color = level_to_color[activity_level['activity_level']]  # Get color from dictionary (default if not found)
    col1, col2 = st.columns(2)
    with col1:
      st.write("")  # Add an empty space for better layout
      circle_html = f"""
        <div style="border-radius: 25%;width: 50px;height: 50px;background-color: {color};"></div>
      """
      st.markdown(circle_html, unsafe_allow_html=True)
    with col2:
      st.write(text) 
      st.write(f""" <p style="color: {color}; font-weight: bold;">{activity_level['activity_level']}</p> """, unsafe_allow_html=True)
      st.write(" protest activity level")

  st.markdown(f"""
      <div style="background-color: {background_color}; font-size: 25px; font-weight: bold;">
  Activity Level Prediction:
</div>
    """, unsafe_allow_html=True)
  st.write("")
  create_circle_box(f'In terms of protest events per 100,000 people, this country will have a relatively ')

