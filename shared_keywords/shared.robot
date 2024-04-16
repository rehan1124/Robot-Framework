*** Settings ***
Documentation    Shared keywords across tests. Contains Setup and Teardown as well.
Library    SeleniumLibrary
Library    Collections
Library    Screenshot

*** Variables ***
${app_url}    https://rahulshettyacademy.com/loginpagePractise/
${browser}    Chrome

*** Keywords ***
Open browser with app url
    Open Browser    url=${app_url}    browser=${browser}
    Maximize Browser Window
    Take Screenshot
    Set Browser Implicit Wait    10s

Close application
    Close Browser