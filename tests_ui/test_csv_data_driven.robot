*** Settings ***
Documentation    Demonstrate data-driven testing using CSV file
Library    SeleniumLibrary
Library    DataDriver    file=test_data/test_csv_data_driven.csv    encoding=utf_8    dialect=unix
Resource    ../pages/login.robot
Resource    ../shared_keywords/shared.robot
Test Setup    Open browser with app url
Test Teardown    Close application
Test Template    Validate unsuccessful login

*** Variables ***
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

*** Test Cases ***
Failed login with ${username} and ${password}    testuser1    learning
    [Tags]    Regression