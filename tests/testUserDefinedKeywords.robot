*** Settings ***
Documentation    Tests with user-defined keywords
Library    SeleniumLibrary
Library    Screenshot
Library    ../user_defined_lib/UserDefinedFuncs.py
Resource    resource.robot
Test Setup    Open browser with app url    ${browser}
Test Teardown    Close application

*** Variables ***
${browser}    Chrome
${validUsername}    rahulshettyacademy
${validPassword}    learning
@{items_list}    Blackberry    Nokia Edge

*** Test Cases ***
Validate multiple items can be added to cart
    Fill login form    ${validUsername}    ${validPassword}
    Wait until "Checkout" button is displayed
    Add Multiple Items To Cart    ${items_list}
    Validate products added in cart    2