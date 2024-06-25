import logging

import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger()

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Activist, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.markdown("<h3 style='text-align: center; color: black;'>Would would you like to do today?</h3>", unsafe_allow_html=True)
st.write('')

col1, col2 = st.columns(2)

with col1:
    st.markdown("<h4 style='text-align: center; color: black;'>Community Forum</h4>", unsafe_allow_html=True)
    if st.button('View Posts',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/10_View_Posts.py')
        
    if st.button('My Posts',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/14_my_posts.py')

    if st.button('Create a New Post',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/11_New_Post.py')

with col2: 
    st.markdown("<h4 style='text-align: center; color: black;'>Protests</h4>", unsafe_allow_html=True)
    if st.button('View Protests',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/20_View_Protests.py')

    if st.button('My Protest',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/26_my_protests.py')

    if st.button('Create a New Protest',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/21_New_Protest.py')