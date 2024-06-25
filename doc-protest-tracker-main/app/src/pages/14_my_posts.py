import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('My Posts')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}. Check out your posts here.")

col1, col2, col3 = st.columns(3)
if st.session_state['role'] != 'politician':
  
  with col1:
    if st.button(label = "Add Post",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/11_New_Post.py')


data = {} 
try:
  data = requests.get(f"http://api:4000/psts/myposts/{st.session_state['user_id']}").json()

except:
  st.write("**Important**: Could not connect to sample api, so using dummy data.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

def delete_post(post_id):
    api_url = f"http://api:4000/psts/post/{post_id}"
    response = requests.delete(api_url)
    return response

# Define a function to create a card for each post
def create_card(post):
    with st.container():
        
        date = str(post['creation_date'][:16])
        st.markdown(f"""
        <div style="border: 1px solid #ddd; padding: 20px; border-radius: 8px;">
            <h3>{post['title']}</h3>
            <p>{post['text']}</p>
             <small>Posted by {post['first_name']} {post['last_name']} on {date}</small>
        </div>
        """, unsafe_allow_html=True)

        col1, col2 = st.columns(2)

        ## Add a delete and update button 
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
if data != {'error': 'Post not found'}:
  for post in data:
      create_card(post)
else: 
   st.write("You have no posts.")