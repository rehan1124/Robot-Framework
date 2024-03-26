*** Settings ***
Documentation    A file with all reusable Keywords and Variables
Library    SeleniumLibrary
Library    Collections
Library    Screenshot

*** Variables ***
${appUrl}    https://rahulshettyacademy.com/loginpagePractise/
${usernameId}    id:username
${passwordId}    id:password
${termsCheckboxId}    id:terms
${signInBtnId}    id:signInBtn
${errorMsgCss}    css:form[id='login-form'] [class*='alert alert-danger']
${checkoutXpath}    xpath://a[contains(text(), 'Checkout')]
${itemCards}    css:app-card-list h4[class='card-title']
${navbar}    xpath://div[@id='navbarResponsive']
${userCategoryXpath}    css:select.form-control
${popupOkayBtnId}    css:button#okayBtn

*** Keywords ***
Open browser with app url
    [Arguments]    ${browser}
    Create Webdriver    ${browser}
    Go To    ${appUrl}
    Maximize Browser Window
    Take Screenshot
    Set Browser Implicit Wait    10s

Fill login form
    [Arguments]    ${username}    ${password}
    Input Text    ${usernameId}    ${username}
    Input Password    ${passwordId}    ${password}
    Select Checkbox    ${termsCheckboxId}
    Click Button    ${signInBtnId}
    Take Screenshot

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${errorMsgCss}
    Take Screenshot

Validate error message is correct
    [Arguments]    ${errorMessage}
    Wait Until Element Contains    ${errorMsgCss}    ${errorMessage}
    Take Screenshot

Close application
    Close Browser

Wait until "Checkout" button is displayed
    Wait Until Element Is Visible    ${checkoutXpath}
    Take Screenshot

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
    Take Screenshot
    
Add items to cart
    [Arguments]    ${item}
    Click Button    xpath://a[text()='${item}']//ancestor::app-card//button[contains(text(), 'Add')]
    Take Screenshot
    
Validate products added in cart
    [Arguments]    ${itemCount}
    Element Should Be Visible    ${navbar}//a[contains(text(), 'Checkout ( ${itemCount} )')]
    Scroll Element Into View    ${navbar}//a[contains(text(), 'Checkout ( ${itemCount} )')]
    Take Screenshot

Enter user credentials
    [Arguments]    ${username}    ${password}
    Input Text    ${usernameId}    ${username}
    Input Password    ${passwordId}    ${password}
    Take Screenshot
    
Select user type
    [Arguments]    ${type}
    Click Element    xpath://span[contains(text(), '${type}')]/..//span[@class='checkmark']
    Wait Until Element Is Visible    ${popupOkayBtnId}
    Sleep    5s
    Click Button    ${popupOkayBtnId}
    Take Screenshot

Select user category
    [Arguments]    ${category}
    IF    '${category}' == 'Consultant'
        Select From List By Value    ${userCategoryXpath}    consult
    ELSE IF    '${category}' == 'Student'
        Select From List By Value    ${userCategoryXpath}    stud
    ELSE IF    '${category}' == 'Teacher'
        Select From List By Value    ${userCategoryXpath}    teach
    END
    Take Screenshot

Click "Sign In" button
    Click Button    ${signInBtnId}
    Take Screenshot    