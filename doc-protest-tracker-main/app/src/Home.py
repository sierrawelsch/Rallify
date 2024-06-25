import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

st.session_state['authenticated'] = False
SideBarLinks(show_home=True)

st.title('Rallify')

st.write('\n\n')
st.write('### Hello! As which user would you like to log in?')

if st.button("Act as Sally, a student activist at Columbia University",
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'activist'
    st.session_state['first_name'] = 'Sally'
    st.session_state['last_name'] = 'Clark'
    st.session_state['user_id'] = 1
    st.session_state['post_id'] = 0
    st.switch_page('pages/00_Activist_Home.py')

if st.button('Act as Peter, the president of the United States',
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'politician'
    st.session_state['first_name'] = 'Peter'
    st.session_state['last_name'] = 'McGuinness'
    st.session_state['user_id'] = 2
    st.switch_page('pages/01_Politician_Home.py')

if st.button('Act as Sydney, a reporter at the New York Times',
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'journalist'
    st.session_state['first_name'] = 'Sydney'
    st.session_state['last_name'] = 'Stone'
    st.session_state['user_id'] = 3
    st.switch_page('pages/02_Journalist_Home.py')
