*** Settings ***
Documentation    A file with all reusable Keywords and Variables
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${appUrl}    https://rahulshettyacademy.com/loginpagePractise/
${usernameId}    id:username
${passwordId}    id:password
${termsCheckboxId}    id:terms
${signInBtnId}    id:signInBtn
${errorMsgCss}    css:form[id='login-form'] [class*='alert alert-danger']
${checkoutXpath}    xpath://a[contains(text(), 'Checkout')]
${itemCards}    css:app-card-list h4[class='card-title']

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

Validate items present in the app
    [Arguments]    ${item1}    ${item2}    ${item3}    ${item4}
    @{expectedItems}=    Create List    ${item1}    ${item2}    ${item3}    ${item4}
    ${actualItems}=    Get Webelements    ${itemCards}
    @{actualItemTitle}=    Create List    
    FOR    ${items}    IN    @{actualItems}
        ${itemTitle}=    Get Text   ${items}
        Log    ${itemTitle}
        Append To List    ${actualItemTitle}    ${itemTitle}
    END
    Lists Should Be Equal    ${expectedItems}    ${actualItemTitle}