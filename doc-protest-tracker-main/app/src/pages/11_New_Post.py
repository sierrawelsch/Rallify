import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests
from datetime import date

st.set_page_config(layout = 'wide')

SideBarLinks()



st.title("Create a New Post")

user_id = st.text_input("Username", value=(str(st.session_state['first_name']) + " " + str(st.session_state['last_name'])), disabled = True)

title = st.text_input("Post Title")
creation_date = st.date_input("Creation Date", value=date.today(), disabled = True)
text = st.text_area("Post Description")

causes = requests.get('http://api:4000/cause/cause').json()
cause_names =  [cause['cause_name'] for cause in causes]
selected_cause = st.selectbox("Select Cause", options=cause_names, placeholder="Choose an option")
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

# Submission Button
if st.button("Submit"):
    if user_id and title and creation_date and text and selected_cause:
        cause = cause_mapping[selected_cause]
        user_id = st.session_state['user_id']
        api_url = "http://api:4000//psts/addpost"
        payload = {
                "user_id": user_id,
                "title": title,
                "creation_date": str(creation_date),
                "text": text,
                "cause": cause,
              
        }
        response = requests.post(api_url, json=payload)
        
        if response.status_code == 201 or response.status_code == 200:
            st.success("Post submitted successfully!")
        else:
            st.error("Failed to submit post. Please try again.")
    else:
        st.warning("Please fill in all fields.")