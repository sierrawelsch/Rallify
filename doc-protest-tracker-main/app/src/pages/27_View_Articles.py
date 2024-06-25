import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests
import logging 
from datetime import date

import logging 
from datetime import date



logger = logging.getLogger()

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page

st.header('News Articles')


# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

sources = requests.get('http://api:4000/articles/sources').json()
sources_names = sources['source_names']
# cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

# add filtering on the sidebar to filter the data by cause with checkboxes
st.sidebar.header('Filter Articles')

# Inputs for filtering
published_date = st.sidebar.date_input('Published Date', value=None, max_value=date.today())

# Multi-select for sources
selected_sources = st.sidebar.multiselect("Select Sources", options=sources_names)

params = {}

# Button to trigger the filter action
if st.sidebar.button('Filter Articles'):
    # Construct the query parameters
    if published_date:
        params['published_date'] = published_date
        logger.info(f'published_date = {published_date}')
    if selected_sources:
        params['sources'] = selected_sources
        logger.info(f'selected_sources = {selected_sources}')

data = {}
try:
  logger.info(f'sending filters: {params}')
  data = requests.get('http://api:4000/articles/all', params = params).json()       
  if len(data) == 0:
    st.write("No articles found with the selected filters.")
  else:
    # Convert data to pandas DataFrame 
    df = pd.DataFrame(data)
    # Display articles in a table
    st.dataframe(df)
except:
    st.write("**Important**: Could not connect to sample api")