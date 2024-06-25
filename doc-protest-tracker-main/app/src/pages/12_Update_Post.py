import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests


import logging

logger = logging.getLogger(__name__)

SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def update_post(post_id, title, text):
    api_url = "http://api:4000/psts/post"
    payload = {
        "post_id": post_id,
        "title": title,
        "text": text
    }
    return requests.put(api_url, json=payload)


# makes a call to the post api for a single post based on sessionstate[postid]
preload_post = requests.get(f"http://api:4000/psts/post/{st.session_state['post_id']}").json()
preload_post = preload_post[0]
logger.info(preload_post)

# populates the update form with sessionstate[postid] data, make call to api to get post, then populate the form with the data
st.write("### Update Post")
post_id = st.text_input("Post ID to Update", value=preload_post['post_id'], disabled = True)
title = st.text_input("New Post Title", value=preload_post['title'])
text = st.text_area("Update your post here...", value=preload_post['text'])

col1, col2, col3 = st.columns(3)

with col1:
    if st.button("Update Post", use_container_width = True):
        if post_id and title and text:
            if title != preload_post['title'] or text != preload_post['text']:
                response = update_post(post_id, title, text)
                if response.status_code == 200:
                    st.success("Post updated successfully!")
                else:
                    st.error(f"Failed to update post ({response.status_code}). Please try again.")
            else: 
                st.warning("No Changes detected.")
        else:
            st.warning("Please fill in all fields.")

with col2:
    if st.button("Back", use_container_width = True):
        st.switch_page("pages/14_my_posts.py")