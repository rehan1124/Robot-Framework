*** Settings ***
Documentation    A file with all reusable Keywords and Variables
Library    SeleniumLibrary
Library    Collections
Library    Screenshot

*** Variables ***
${app_url}    https://rahulshettyacademy.com/loginpagePractise/
${username_id}    id:username
${password_id}    id:password
${terms_checkbox_id}    id:terms
${signin_btn_id}    id:signInBtn
${errormsg_css}    css:form[id='login-form'] [class*='alert alert-danger']
${checkout_xpath}    xpath://a[contains(text(), 'Checkout')]
${item_cards}    css:app-card-list h4[class='card-title']
${navbar}    xpath://div[@id='navbarResponsive']
${user_category_xpath}    css:select.form-control
${popup_okaybtn_id}    css:button#okayBtn
${course_material_partiallinktext}    partial link:Free Access to InterviewQues
${mentor_email_css}    css:p[class*='red'] a[href*='mailto']

*** Keywords ***
Open browser with app url
    [Arguments]    ${browser}
    Create Webdriver    ${browser}
    Go To    ${app_url}
    Maximize Browser Window
    Take Screenshot
    Set Browser Implicit Wait    10s

Fill login form
    [Arguments]    ${username}    ${password}
    Input Text    ${username_id}    ${username}
    Input Password    ${password_id}    ${password}
    Select Checkbox    ${terms_checkbox_id}
    Click Button    ${signin_btn_id}
    Take Screenshot

Wait until it checks and displays error message
    Wait Until Element Is Visible    ${errormsg_css}
    Take Screenshot

Validate error message is correct
    [Arguments]    ${errorMessage}
    Wait Until Element Contains    ${errormsg_css}    ${errorMessage}
    Take Screenshot

Close application
    Close Browser

Wait until "Checkout" button is displayed
    Wait Until Element Is Visible    ${checkout_xpath}
    Take Screenshot

Validate items present in the app
    [Arguments]    ${item1}    ${item2}    ${item3}    ${item4}
    @{expectedItems}=    Create List    ${item1}    ${item2}    ${item3}    ${item4}
    ${actualItems}=    Get Webelements    ${item_cards}
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
    Input Text    ${username_id}    ${username}
    Input Password    ${password_id}    ${password}
    Take Screenshot
    
Select user type
    [Arguments]    ${type}
    Click Element    xpath://span[contains(text(), '${type}')]/..//span[@class='checkmark']
    Wait Until Element Is Visible    ${popup_okaybtn_id}
    Sleep    5s
    Click Button    ${popup_okaybtn_id}
    Take Screenshot

Select user category
    [Arguments]    ${category}
    IF    '${category}' == 'Consultant'
        Select From List By Value    ${user_category_xpath}    consult
    ELSE IF    '${category}' == 'Student'
        Select From List By Value    ${user_category_xpath}    stud
    ELSE IF    '${category}' == 'Teacher'
        Select From List By Value    ${user_category_xpath}    teach
    END
    Take Screenshot

Click "Sign In" button
    Click Button    ${signin_btn_id}
    Take Screenshot

Click on "Free Access to InterviewQues ..." link
    Wait Until Element Is Visible    ${course_material_partiallinktext}
    Click Element    ${course_material_partiallinktext}
    Switch Window    NEW
    Take Screenshot

Validate user is on "RS Academy" page
    [Arguments]    ${pageTitle}
    Title Should Be    ${pageTitle}
    Take Screenshot

Validate mentor email present on page
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${mentor_email_css}
    Scroll Element Into View    ${mentor_email_css}
    Sleep    5s
    Element Text Should Be    ${mentor_email_css}    ${email}
    Take Screenshot

Validate user can navigate back to main page
    [Arguments]    ${pageTitle}
    Switch Window    MAIN
    Title Should Be    ${pageTitle}
    Take Screenshot