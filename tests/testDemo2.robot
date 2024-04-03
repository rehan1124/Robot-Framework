*** Settings ***
Documentation    Test to open hyperlinks
Library    SeleniumLibrary
Resource    resource.robot
Test Setup    Open browser with app url    ${browser}
Test Teardown    Close application

*** Variables ***
${browser}    Chrome
${mentorEmail}    mentor@rahulshettyacademy.com
${mainPageTitle}    LoginPage Practise | Rahul Shetty Academy
${rsAcademyTitle}    RS Academy

*** Test Cases ***
Validate user is navigated to "RS Academy" page when clicking on hyperlink
    Click On "Free Access To InterviewQues ..." Link
    Validate user is on "RS Academy" page    ${rsAcademyTitle}
    Validate mentor email present on page    ${mentorEmail}
    Validate user can navigate back to main page    ${mainPageTitle}