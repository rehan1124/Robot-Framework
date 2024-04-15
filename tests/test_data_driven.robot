*** Settings ***
Documentation    Demonstrate data-driven testing or parameterization
Library    SeleniumLibrary
Resource    ../pages/login.robot
Resource    ../shared_keywords/shared.robot
Test Setup    Open browser with app url    ${browser}
Test Teardown    Close application
Test Template    Validate unsuccessful login

*** Variables ***
${browser}    Headless Chrome
${errorMessage}    Incorrect username/password.

*** Keywords ***
Validate unsuccessful login
    [Arguments]    ${username}    ${password}
    Log Many    ${username}    ${password}
    Fill login form    ${username}    ${password}
    Wait until it checks and displays error message
    Validate error message is correct    ${errorMessage}
    Log Many    ${errorMessage}
    Take Screenshot
    
*** Test Cases ***    username    password
Invalid username    testuser1    learning
Invalid password    rahulshettyacademy    testuser1
Invalid username & password    %&*~!@    4328239472398
