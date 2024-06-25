# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

import streamlit as st
from st_pages import Page, Section, show_pages, add_page_title


#### ------------------------ Home/About Page ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon='🏠')
def AboutPageNav():
    st.sidebar.page_link("pages/50_About.py", label="About", icon='👥')

#### ------------------------ Home Pages ------------------------
def ActivistHomeNav():
    st.sidebar.page_link("pages/00_Activist_Home.py", label="Activist Home", icon='👥')

def PoliticianHomeNav():
    st.sidebar.page_link("pages/01_Politician_Home.py", label="Politician Home", icon='🎩')

def JournalistHomeNav():
    st.sidebar.page_link("pages/02_Journalist_Home.py", label="Journalist Home", icon='📰')

#### ------------------------ Post Pages ------------------------
def ViewPostsNav():
    st.sidebar.page_link("pages/10_View_Posts.py", label="All Posts", icon='📄')

def MyPostsPostsNav():
    st.sidebar.page_link("pages/14_my_posts.py", label="My Posts", icon='💬')

def NewPostNav():
    st.sidebar.page_link("pages/11_New_Post.py", label="New Post", icon='✍️')

# def UpdateDeletePostNav():
#     st.sidebar.page_link("pages/12_Update_Delete_Post.py", label="Update/Delete Post", icon='📝')

def DeletePostNav():
    st.sidebar.page_link("pages/12_Update_Post.py", label="Delete Post", icon='📝')

def UpdatePostNav():
    st.sidebar.page_link("pages/13_Delete_Post.py", label="Edit Post", icon='🗑️')


#### ------------------------ Protest Pages ------------------------
def ViewProtestsNav():
    st.sidebar.page_link("pages/20_View_Protests.py", label="All Protests", icon='✊')

def MyProtestsNav():
    st.sidebar.page_link("pages/26_my_protests.py", label="My Protests", icon='📢')

def NewProtestNav():
    st.sidebar.page_link("pages/21_New_Protest.py", label="New Protest", icon='🚩')

# def UpdateDeleteProtestNav():
#     st.sidebar.page_link("pages/22_Update_Delete_Protest.py", label="Update/Delete Protest", icon='✏️')

def DeleteProtestNav():
    st.sidebar.page_link("pages/23_Delete_Protests.py", label="Remove Protest", icon='✏️')

def UpdateProtestNav():
    st.sidebar.page_link("pages/22_Update_Protest.py", label="Update Protest", icon='✏️')

def CompareProtestsNav():
    st.sidebar.page_link("pages/23_Compare_Protests.py", label="Compare Protests", icon='⚖️')

def SaveProtestsNav():
    st.sidebar.page_link("pages/24_Save_Protests.py", label="Save Protests", icon='💾')

def ViewProtestMapNav():
    st.sidebar.page_link("pages/25_View_Protest_Map.py", label="View Protest Map", icon='🗺️')

#### ------------------------ Country Pages ------------------------
def ViewCountriesNav():
    st.sidebar.page_link("pages/30_View_Countries.py", label="View Countries", icon='🌍')

def CompareCountriesNav():
    st.sidebar.page_link("pages/31_Compare_Countries.py", label="Compare Countries", icon='🌐')

#### ------------------------ Model Pages ------------------------
def ViewModel1Nav():
    st.sidebar.page_link("pages/41_Model_1.py", label="View Model 1", icon='📈')

def ViewModel2Nav():
    st.sidebar.page_link("pages/42_Model_2.py", label="View Model 2", icon='🔭')

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in. 
    """    

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo-Photoroom.png", width = 200)

    # If there is no logged in user, redirect to the Home (Landing) page
    if 'authenticated' not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page('Home.py')
        
    # if show_home:
    #     # Show the Home page link (the landing page)
    #     HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # If the user role is student activist, show the activist pages
        if st.session_state['role'] == 'activist':
            ActivistHomeNav()
            ViewPostsNav()
            MyPostsPostsNav()
            NewPostNav()

            ViewProtestsNav()
            MyProtestsNav()
            NewProtestNav()

        #  If the user is a politician, show the politician pages
        if st.session_state['role'] == 'politician':
            PoliticianHomeNav()
            ViewProtestsNav()
            ViewProtestMapNav()
            ViewModel1Nav()
        
        # If the user is a journalist, show the journalist pages
        if st.session_state['role'] == 'journalist':
            JournalistHomeNav()
            ViewPostsNav()
            MyPostsPostsNav()
            NewPostNav()

            ViewProtestsNav()
            ViewCountriesNav()
            CompareCountriesNav()
            ViewModel1Nav()
            ViewModel2Nav()

    # if on the about page and not logged in, show the home page link
    if not st.session_state["authenticated"]:
        HomeNav()
        
    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state['role']
            del st.session_state['authenticated']
            st.switch_page('Home.py')