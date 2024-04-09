*** Settings ***
Documentation    Tests with user-defined keywords
Library    SeleniumLibrary
Library    ../user_defined_lib/UserDefinedFuncs.py
Resource    resource.robot
Test Setup    Open browser with app url    ${browser}
Test Teardown    Close application

*** Variables ***
${browser}    Chrome

*** Test Cases ***
Test with user defined keywords
    Hello World