*** Settings ***
Documentation    Login page keywords and locators
Library    SeleniumLibrary
Library    Collections
Library    Screenshot

*** Variables ***
${username_id}    id:username
${password_id}    id:password
${terms_checkbox_id}    id:terms
${signin_btn_id}    id:signInBtn
${errormsg_css}    css:form[id='login-form'] [class*='alert alert-danger']
${user_category_xpath}    css:select.form-control
${popup_okaybtn_id}    css:button#okayBtn
${course_material_partiallinktext}    partial link:Free Access to InterviewQues

*** Keywords ***
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

Validate user can navigate back to main page
    [Arguments]    ${pageTitle}
    Switch Window    MAIN
    Title Should Be    ${pageTitle}
    Take Screenshot