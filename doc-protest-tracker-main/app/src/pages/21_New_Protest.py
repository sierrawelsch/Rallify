import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()


st.title("Create a New Protest")

country_names = requests.get('http://api:4000/cntry/names').json()

causes = requests.get('http://api:4000/cause/cause').json()
cause_names =  [cause['cause_name'] for cause in causes]

cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

user_id = st.text_input("Username", value=(str(st.session_state['first_name']) + " " + str(st.session_state['last_name'])), disabled = True)
location = st.text_input("Location (City)")
date = st.date_input("Protest Date", value = None)
country = st.selectbox("Country", options=country_names, index = None, placeholder="Choose an option")

selected_cause = st.selectbox("Select Cause", options=cause_names, placeholder="Choose an option")
description = st.text_area("Protest Description")


# Submission Buttongit 
if st.button("Submit"):
    if user_id and location and date and country and selected_cause:
        cause = cause_mapping[selected_cause] # get the cause_id from the cause name

        api_url = "http://api:4000//prtsts/addprotest"
        payload = {
                "user_id": user_id,
                "location": location,
                "date": str(date),
                "country": country,
                "cause": cause,
                "description": description
            }
        response = requests.post(api_url, json=payload)
        
        if response.status_code == 201 or response.status_code == 200:
            st.success("Post submitted successfully!")
        else:
            st.error("Failed to submit post. Please try again.")
    else:
        st.warning("Please fill in all fields.")