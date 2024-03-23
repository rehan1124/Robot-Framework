*** Settings ***
Documentation    Test to validate Login page
Library    SeleniumLibrary

*** Test Cases ***
Validate unsuccessful login
    Open browser with app url
    Fill login form
    Wait until it checks and displays error message
    Validate error message is correct

*** Keywords ***
Open browser with app url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/
    Maximize Browser Window

Fill login form
    Input Text    id:username    testuser1
    Input Password    id:password    testuser1
    Select Checkbox    id:terms
    Click Button    id:signInBtn

Wait until it checks and displays error message
    Wait Until Element Is Visible    css:form[id='login-form'] [class*='alert alert-danger']

Validate error message is correct
    Wait Until Element Contains    css:form[id='login-form'] [class*='alert alert-danger']    Incorrect username/password.