import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# add filtering options on the sidebar based on region (Western, Asia, South America), protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate
st.sidebar.header('Filter Countries')
# multi-select input for region
# make the maximum number of selections in the multi-select input to be 1

region = st.sidebar.multiselect('Region', ['Western', 'Eastern Europe', 'Asia', 'South America'], default=[])
protests_per_capita_min, protests_per_capita_max = st.sidebar.slider('Protests Per Capita', 0, 200, (0, 200))
population_min, population_max = st.sidebar.slider('Population', 0, 2000000000, (0, 2000000000))
gdp_per_capita_min, gdp_per_capita_max = st.sidebar.slider('GDP Per Capita', 0, 200000, (0, 200000))
unemployment_rate_min, unemployment_rate_max = st.sidebar.slider('Unemployment Rate', 0.0, 50.0, (0.0, 50.0))
urbanization_rate_min, urbanization_rate_max = st.sidebar.slider('Urbanization Rate', 0.0, 100.0, (0.0, 100.0))
inflation_rate_min, inflation_rate_max = st.sidebar.slider('Inflation Rate', 0.0, 300.0, (0.0, 300.0))

# set the header of the page.
st.header('Countries')

if st.button(label = "Compare Two Countries",
             type = 'primary',
             use_container_width=True):
  st.switch_page('pages/31_Compare_Countries.py')

data = {} 
try:
  params = {
    'region': region,
    'protests_per_capita_min': protests_per_capita_min,
    'protests_per_capita_max': protests_per_capita_max,
    'population_min': population_min,
    'population_max': population_max,
    'gdp_per_capita_min': gdp_per_capita_min,
    'gdp_per_capita_max': gdp_per_capita_max,
    'unemployment_rate_min': unemployment_rate_min,
    'unemployment_rate_max': unemployment_rate_max,
    'urbanization_rate_min': urbanization_rate_min,
    'urbanization_rate_max': urbanization_rate_max,
    'inflation_rate_min': inflation_rate_min,
    'inflation_rate_max': inflation_rate_max
  }
  data = requests.get('http://api:4000/cntry/countries', params=params).json()
except:
  st.write("**Important**: Could not connect to sample api, so using dummy data.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

# rename the columns to be more professional
data = pd.DataFrame(data)
data = data.rename(columns={'country_name': 'Country Name', 'region': 'Region', 'protests_per_capita': 'Protests Per 100,000', 'population': 'Population', 'gdp_per_capita': 'GDP Per Capita', 'unemployment_rate': 'Unemployment Rate', 'urbanization_rate': 'Urbanization Rate', 'inflation_rate': 'Inflation Rate'})
st.table(data)