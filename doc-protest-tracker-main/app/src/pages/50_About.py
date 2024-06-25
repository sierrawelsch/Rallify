import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About this App")

st.markdown (
    """
    Rallify is a powerful platform designed to empower political protest movements worldwide. 
    We provide activists with the tools they need to connect, organize, and amplify their voices. 
    Our community forum fosters collaboration and knowledge-sharing, while our comprehensive protest 
    database helps users discover events and connect with allies.

    But Rallify is more than just a networking tool. We leverage machine learning to analyze 
    protest data and provide valuable insights. These can help users understand trends worldwide. 
    Whether you're an activist on the front lines, a journalist reporting on the movement, or a 
    politician seeking to understand constituent concerns, Rallify provides the data and tools you 
    need to make a difference.
    
    This app was built for Northeastern University's Summer 2024 Dialogue of Civilization Program 
    titled *Data and Software in International Government and Politics*.  The program was being
    led by Dr. Mark Fontenot and Dr. Eric Gerber from the Khoury College of Computer Sciences.  
    """
        )

