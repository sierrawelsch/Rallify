import logging

import requests
import streamlit as st # type: ignore
from modules.nav import SideBarLinks

logger = logging.getLogger()

st.set_page_config(layout="wide")

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title("Compare Countries")

# makes two columns to get two countries and compare them
col1, col2 = st.columns(2)
countries = 'Brazil|Mexico|Colombia|Argentina|Chile|Uruguay|Jamaica|Costa%20Rica|India|Indonesia|Japan|Philippines|Thailand|South%20Korea|Taiwan|Israel|Mongolia|United%20States|Canada|Germany|United%20Kingdom|France|Italy|Spain|Portugal|Belgium|Austria|Finland|Norway|Sweden|Switzerland|Ireland|Singapore|Netherlands|Denmark|Iceland|Luxembourg|Albania|Bulgaria|Croatia|Czech%20Republic|Estonia|Greece|Hungary|Kosovo|Latvia|Lithuania|Malta|Poland|Romania|Serbia|Slovakia|Slovenia|Australia'
with col1:
    # make a dropdown with all the countries with default value of Brazil
    country1 = st.selectbox("Country 1", countries.split('|'))
    c1_data = requests.get(f'http://api:4000/cntry/country/{country1}').json()

with col2:
    # make a dropdown with all the countries with a default value of Mexico
    country2 = st.selectbox("Country 2", countries.split('|'), index=1)
    c2_data = requests.get(f'http://api:4000/cntry/country/{country2}').json()
    # makes a table to display the data
    # st.table(c2_data)

# make a st.markdown object that is a table with both countries, and the features country	gdp_per_capita	inflation_rate	population	protests_per_capita	unemployment_rate	urbanization_rate side by side
if c1_data and c2_data:
    st.markdown(f"""
    <style>
    table {{
        width: 100%;
        font-size: 16px;
    }}
    th, td {{
        padding: 10px;
        text-align: left;
    }}
    </style>

    <table>
    <tr>
        <th>Feature</th>
        <th>{country1}</th>
        <th>{country2}</th>
    </tr>
    <tr>
        <td>GDP Per Capita</td>
        <td>{c1_data[0]['gdp_per_capita']}</td>
        <td>{c2_data[0]['gdp_per_capita']}</td>
    </tr>
    <tr>
        <td>Inflation Rate</td>
        <td>{c1_data[0]['inflation_rate']}</td>
        <td>{c2_data[0]['inflation_rate']}</td>
    </tr>
    <tr>
        <td>Population</td>
        <td>{c1_data[0]['population']}</td>
        <td>{c2_data[0]['population']}</td>
    </tr>
    <tr>
        <td>Protests Per 100,000 people</td>
        <td>{c1_data[0]['protests_per_capita']}</td>
        <td>{c2_data[0]['protests_per_capita']}</td>
    </tr>
    <tr>
        <td>Unemployment Rate</td>
        <td>{c1_data[0]['unemployment_rate']}</td>
        <td>{c2_data[0]['unemployment_rate']}</td>
    </tr>
    <tr>
        <td>Urbanization Rate</td>
        <td>{c1_data[0]['urbanization_rate']}</td>
        <td>{c2_data[0]['urbanization_rate']}</td>
    </tr>
    </table>
    """, unsafe_allow_html=True)
