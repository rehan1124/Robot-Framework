*** Settings ***
Documentation    A file with all reusable Keywords and Variables
Library    SeleniumLibrary

*** Variables ***
${appUrl}    https://rahulshettyacademy.com/loginpagePractise/
${usernameId}    id:username
${passwordId}    id:password
${termsCheckboxId}    id:terms
${signInBtnId}    id:signInBtn
${errorMsgCss}    css:form[id='login-form'] [class*='alert alert-danger']
${checkoutXpath}    xpath://a[contains(text(), 'Checkout')]

*** Keywords ***
Open browser with app url
    [Arguments]    ${browser}
    Create Webdriver    ${browser}
    Go To    ${appUrl}
    Maximize Browser Window

Fill login form
    [Arguments]    ${username}    ${password}
    Input Text    ${usernameId}    ${username}
    Input Password    ${passwordId}    ${password}
    Select Checkbox    ${termsCheckboxId}
    Click Button    ${signInBtnId}

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${errorMsgCss}

Validate error message is correct
    [Arguments]    ${errorMessage}
    Wait Until Element Contains    ${errorMsgCss}    ${errorMessage}

Close application
    Close Browser

Wait until "Checkout" button is displayed
    Wait Until Element Is Visible    ${checkoutXpath}