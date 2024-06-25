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

st.header('Community Post Forum')


# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

# add filtering on the sidebar to filter the data by cause with checkboxes
st.sidebar.header('Filter Data')

causes = requests.get('http://api:4000/cause/cause').json()
cause_names = [cause['cause_name'] for cause in causes]
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

users = requests.get('http://api:4000/users/usernames').json()
usernames = [user['full_name'] for user in users]
user_mapping = {user['full_name']: user['user_id'] for user in users}

# Inputs for filtering
creation_date = st.sidebar.date_input('Creation Date', value=None, max_value=date.today())

# Multi-select for causes
selected_causes = st.sidebar.multiselect("Select Causes", options=cause_names)
selected_cause_ids = [cause_mapping[cause] for cause in selected_causes]

# Multi-select for usernames
selected_usernames = st.sidebar.multiselect('Select Usernames', options=usernames)
selected_user_ids = [user_mapping[username] for username in selected_usernames]

params = {}
# Button to trigger the filter action
if st.sidebar.button('Filter Posts'):
    # Construct the query parameters
    if creation_date:
        params['creation_date'] = creation_date
        logger.info(f'creation_date = {creation_date}')
    if selected_user_ids:
        params['created_by'] = selected_user_ids
    if selected_causes:
        params['cause'] = selected_cause_ids
    

col1, col2, col3 = st.columns(3)
if st.session_state['role'] != 'politician':
  
  with col1:
    if st.button(label = "Add Post",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/11_New_Post.py')

data = {} 
try:
  data = requests.get('http://api:4000/psts/posts', params = params).json()
except:
  st.write("**Important**: Could not connect to sample api, so using dummy data.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

def delete_post(post_id):
  api_url = f"http://api:4000/psts/post/{post_id}"
  response = requests.delete(api_url)
  return response

# Define a function to create a card for each post
def create_card(post):
  # Card Background Colors
    cause_colors = {
    "Racial Inequality": "#E6D7F7",
    "Climate Change": "#F2E8FD",
    "Animal Rights": "#E3F5FD",
    "Black Lives Matter": "#F1F2FD",
    "Political Corruption": "#D7E4F3",
    "Gender Equality": "#E2E2E4",
    "Israeli-Palestine": "#E6F2F8"
}
    date = str(post['creation_date'][:16])
    card_bg_color = cause_colors.get(post['cause_name'], "#FFFFFF")  # Default to white if cause not found
    
    st.markdown(f"""
    <div style="border: 1px solid #ddd; background-color: {card_bg_color}; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h3>{post['title']}</h3>
        <p style="color: grey; font-weight: bold;">{post['cause_name']}</p>
        <p>{post['text']}</p>
        <small>Posted by {post['full_name']}  on {date}</small>
    </div>
    """, unsafe_allow_html=True)

    col1, col2 = st.columns(2)

    # Add a delete and update button 
    if st.session_state['user_id'] == post['created_by']:
        with col1:
          if st.button("Delete", type = 'primary', key=f"delete-{post['post_id']}", use_container_width=True):
            response = delete_post(post['post_id'])
            if response.status_code == 200:
              st.success("Post deleted successfully!")
              st.experimental_rerun()
            else:
              st.error(f"Failed to delete post ({response.status_code}). Please try again.")
        with col2:
          if st.button("Update", type = 'primary', key=f"update-{post['post_id']}", use_container_width=True):
            st.session_state['post_id'] = post['post_id']
            st.switch_page('pages/12_Update_Post.py')

# Display each post in a card
for post in data:
    create_card(post)


