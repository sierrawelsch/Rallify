import streamlit as st
from streamlit_extras.app_logo import add_logo
import pandas as pd
import pydeck as pdk
from urllib.error import URLError
from modules.nav import SideBarLinks
import requests
from datetime import date
import logging
import plotly.express as px
import time

logger = logging.getLogger()

# Set page configuration
st.set_page_config(layout='wide')
SideBarLinks()

# add the logo
add_logo("assets/logo.jpeg", height=400)



# Set the header of the page
st.header('Protest Map')

st.sidebar.header('Filter Data')

causes = requests.get('http://api:4000/cause/cause').json()
cause_names = [cause['cause_name'] for cause in causes]
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

# Inputs for filtering
date = st.sidebar.date_input('Creation Date', value=None, max_value=date.today())


# Multi-select for causes
selected_causes = st.sidebar.multiselect("Select Causes", options=cause_names)
selected_cause_ids = [cause_mapping[cause] for cause in selected_causes]



params = {}

# Button to trigger the filter action
if st.sidebar.button('Filter Protests'):
    # Construct the query parameters
    
    if date:
        params['date'] = date

    if selected_causes:
        params['cause'] = selected_cause_ids
  

# Fetch protest data
data = requests.get('http://api:4000/prtsts/protests', params = params).json()


# Convert data to DataFrame
df = pd.DataFrame(data)


  

if 'latitude' not in df.columns and 'longitude' not in df.columns and 'cause_name' not in df.columns:
    st.write("No data to display.")
    st.stop()

    # Plotly scatter mapbox plot
fig = px.scatter_mapbox(df, lat='latitude', lon='longitude', 
                        hover_name='cause_name' , zoom=2, height=600)

# Use a mapbox style
fig.update_layout(mapbox_style="carto-positron",
                  width=500,  # Set the width of the map
    height=500,  # Set the height of the map
    margin={"r":0,"t":0,"l":0,"b":0}  # Set the margins
    )
fig.update_layout(clickmode = 'event+select')

# Enhance the plotting dots
fig.update_traces(marker=dict(size=15, color='red', opacity=0.7))

    
def stream_data(results_display):
    for word in results_display.split(" "):
        yield word + " "
        time.sleep(0.05)


pl_chart = st.plotly_chart(fig, use_container_width=True, on_select="rerun")
#pl_chart
if len(pl_chart['selection']['points']) == 0:
    st.markdown("<h4>Click on a point to see details.</h4>", unsafe_allow_html=True)
else: 

    
    lat_long = (pl_chart["selection"]["points"][0]["lat"], pl_chart["selection"]["points"][0]["lon"])

    protest_mapping = {(p['latitude'], p['longitude']): p['protest_id'] for p in data}
    logger.info(f'protest_mapping = {protest_mapping}')

    selected_point = protest_mapping[lat_long]
    logger.info(f'selected_point = {selected_point}')

    protest = requests.get('http://api:4000/prtsts/protests/' + str(selected_point)).json()[0]
    logger.info(f'protest = {protest}')
    
       # Concatenate first name and last name if they exist
    full_name = ""
    if protest['first_name'] is not None:
        full_name +=  protest['first_name']
    if protest['last_name'] is not None:
        full_name += " " + protest['last_name']
    full_name_html = f' | Created By: {full_name}' if full_name else ""

    date = str(protest['date'][:16])

    coords = f'You have selected -- {protest["latitude"]}, {protest["longitude"]}'
    protest_string_data = f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h2>Cause: {protest['cause_name']}</h2>
        <p><strong>Date:</strong> {date}{full_name_html}</p>
        <p>{protest['description']}</p>
    </div>
    """
    st.write_stream(stream_data(coords))
    time.sleep(0.05)
    st.markdown(protest_string_data, unsafe_allow_html=True)
    


#click_data = pl_chart.clickData

#logger.info(f'click_data = {str(click_data)}')


# Display clicked point details
#if click_data:
    # print(click_data)
    #st.table(df)
    #st.write(f"Latitude: {clicked_point['latitude']}")
    #st.write(f"Longitude: {clicked_point['longitude']}")
#else:
#    st.write("Click on a point to see details.")

