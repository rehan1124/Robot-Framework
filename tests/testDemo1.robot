*** Settings ***
Documentation    Test to validate Login page
Library    SeleniumLibrary
Test Setup    Open browser with app url
Test Teardown    Close Browser

*** Variables ***
${browser}    Chrome
${appUrl}    https://rahulshettyacademy.com/loginpagePractise/
${usernameId}    id:username
${passwordId}    id:password
${termsCheckboxId}    id:terms
${signInBtnId}    id:signInBtn
${errorMsgCss}    css:form[id='login-form'] [class*='alert alert-danger']

*** Test Cases ***
Validate unsuccessful login
    Fill login form
    Wait until it checks and displays error message
    Validate error message is correct

*** Keywords ***
Open browser with app url
    Create Webdriver    ${browser}
    Go To    ${appUrl}
    Maximize Browser Window

Fill login form
    Input Text    ${usernameId}    testuser1
    Input Password    ${passwordId}    testuser1
    Select Checkbox    ${termsCheckboxId}
    Click Button    ${signInBtnId}

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${errorMsgCss}

Validate error message is correct
    Wait Until Element Contains    ${errorMsgCss}    Incorrect username/password.
