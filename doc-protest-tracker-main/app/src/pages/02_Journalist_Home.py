import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger()

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Journalist, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

col1, col2, col3, col4 = st.columns(4)

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
    st.markdown("<h4 style='text-align: center; color: black;'> Protests/Articles</h4>", unsafe_allow_html=True)
    if st.button('View Protests',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/20_View_Protests.py')
    if st.button('View Articles',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/27_View_Articles.py')


with col3:
    st.markdown("<h4 style='text-align: center; color: black;'>Countries</h4>", unsafe_allow_html=True)
    if st.button('View Countries',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/30_View_Countries.py')

    if st.button('Compare Countries',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/31_Compare_Countries.py')

with col4:
    st.markdown("<h4 style='text-align: center; color: black;'>ML Models</h4>", unsafe_allow_html=True)
    if st.button('View Model 1',
                type='primary',
                use_container_width=True):
        st.switch_page('pages/41_Model_1.py')

    if st.button('View Model 2',
                    type='primary',
                    use_container_width=True):
            st.switch_page('pages/42_Model_2.py')