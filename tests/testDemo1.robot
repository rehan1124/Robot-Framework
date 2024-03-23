*** Settings ***
Documentation    Test to validate Login page
Library    SeleniumLibrary
Resource    resource.robot
Test Setup    Open browser with app url    ${browser}
Test Teardown    Close application

*** Variables ***
${browser}    Chrome
${invalidUsername}    testuser1
${invalidPassword}    testuser1
${validUsername}    rahulshettyacademy
${validPassword}    learning
${errorMessage}    Incorrect username/password.

*** Test Cases ***
Validate unsuccessful login
    Fill login form    ${invalidUsername}    ${invalidPassword}
    Wait until it checks and displays error message
    Validate error message is correct    ${errorMessage}

Validate successful login
    Fill login form    ${validUsername}    ${validPassword}
    Wait until "Checkout" button is displayed