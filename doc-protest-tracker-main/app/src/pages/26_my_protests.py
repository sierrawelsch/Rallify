import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

import logging

logger = logging.getLogger(__name__)

# set the header of the page
st.header('My Protests')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}. Check out your protests here.")

col1, col2, col3 = st.columns(3)
if st.session_state['role'] != 'politician':
  
  with col1:
    if st.button(label = "Add Protest",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/21_New_Protest.py')


data = {} 
try:
  data = requests.get(f"http://api:4000/prtsts/myprotests/{st.session_state['user_id']}").json()

except:
  st.write("**Important**: Could not connect to sample api, so using dummy data.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

logger.info(data)
def delete_protest(protest_id):
    api_url = f"http://api:4000/prtsts/protest/{protest_id}"
    response = requests.delete(api_url)
    return response

# Define a function to create a card for each post
def create_card(protest):
    
    date = str(protest['date'][:16])
    st.markdown(f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h2>{protest['cause_name']}</h2>
        <h4>{date}</h4>
        <h4>{protest['location']}, {protest['country']} </h4>
        <p>{protest['description']}</p>
    </div>
    """, unsafe_allow_html=True)

    col1, col2 = st.columns(2)

    # Add a delete and update button 
    if st.session_state['user_id'] == protest['created_by']:
            with col1:
              if st.button("Delete", type = 'primary', key=f"delete-{protest['protest_id']}", use_container_width=True):
                  response = delete_protest(protest['protest_id'])
                  if response.status_code == 200:
                    st.success("Protest deleted successfully!")
                    st.experimental_rerun()
                  else:
                    st.error(f"Failed to delete protest ({response.status_code}). Please try again.")
            with col2:
              if st.button("Update", type = 'primary', key=f"update-{protest['protest_id']}", use_container_width=True):
                st.session_state['protest_id'] = protest['protest_id']
                st.switch_page('pages/22_Update_Protest.py')

if data != {'error': 'Protest not found'}:
  for protest in data:
      create_card(protest)
else: 
   st.write("You have no protests.")