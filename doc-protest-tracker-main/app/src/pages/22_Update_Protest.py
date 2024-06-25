import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests
import logging
logger = logging.getLogger()
SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def update_protest(protest_id, location, country, cause, description):
    cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}
    api_url = "http://api:4000/prtsts/protest"
    payload = {
        "protest_id": protest_id,
        "location": location,
        "country": country,
        "cause": cause_mapping[cause],
        "description": description
    }
    return requests.put(api_url, json=payload)

# --- Update Post Section ---
causes = requests.get('http://api:4000/cause/cause').json()
cause_names =  [cause['cause_name'] for cause in causes]
country_names = requests.get('http://api:4000/cntry/names').json()

preload_post = requests.get(f"http://api:4000/prtsts/protests/{st.session_state['protest_id']}").json()
logger.info(preload_post)
preload_post = preload_post[0]

st.write("### Update Protest")
protest_id = st.text_input("Protest ID to Update", value = preload_post['protest_id'], disabled = True)
location = st.text_input("Protest City", value = preload_post['location'])
country = st.selectbox("Country", options=country_names, index = country_names.index(preload_post['protest_country']), placeholder="Choose an option")
cause = st.selectbox("Protest Cause", index = preload_post['cause'] - 1, options=cause_names)
description = st.text_area("Update your Protest here...", value = preload_post['description'])

col1, col2, col3 = st.columns(3)

with col1:
    if st.button("Update Protest", use_container_width = True):
        if protest_id and location and description and country and cause:
            if location!= preload_post['location'] or description != preload_post['description'] or country != preload_post['protest_country'] or cause != preload_post['cause_name']:
                response = update_protest(protest_id, location, country, cause, description)
                logger.info(response)
                logger.info("Status code is: "+ str(response.status_code))
                if response.status_code == 200:
                    st.success("Protest updated successfully!")
                else:
                    st.error(f"Failed to update protest ({response.status_code}). Please try again.")
            else:
                st.warning("No changes detected")

with col2:
    if st.button("Back"):
        st.switch_page("pages/26_my_protests.py")