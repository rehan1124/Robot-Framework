*** Settings ***
Documentation    Test to validate Login page
Library    SeleniumLibrary
Resource    ../shared_keywords/shared.robot
Resource    ../pages/login.robot
Resource    ../pages/home.robot
Test Setup    Open browser with app url
Test Teardown    Close application

*** Variables ***
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
    [Tags]    Smoke
    Fill login form    ${validUsername}    ${validPassword}
    Wait until "Checkout" button is displayed
    Validate items present in the app    iphone X    Samsung Note 8    Nokia Edge    Blackberry

Validate items can be added to cart
    [Tags]    Smoke
    Fill login form    ${validUsername}    ${validPassword}
    Wait until "Checkout" button is displayed
    Add items to cart    Blackberry
    Validate products added in cart    1
    Add items to cart    Nokia Edge
    Validate products added in cart    2

Validate login with type "User"
    Enter user credentials    ${validUsername}    ${validPassword}
    Select user type    User
    Select user category    Teacher
    Click "Sign In" button
    Wait until "Checkout" button is displayed