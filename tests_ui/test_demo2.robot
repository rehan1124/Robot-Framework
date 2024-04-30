*** Settings ***
Documentation    Test to open hyperlinks
Library    SeleniumLibrary
Resource    ../shared_keywords/shared.robot
Resource    ../pages/login.robot
Resource    ../pages/home.robot
Test Setup    Open browser with app url
Test Teardown    Close application

*** Variables ***
${mentorEmail}    mentor@rahulshettyacademy.com
${mainPageTitle}    LoginPage Practise | Rahul Shetty Academy
${rsAcademyTitle}    RS Academy

*** Test Cases ***
Validate user is navigated to "RS Academy" page when clicking on hyperlink
    Click On "Free Access To InterviewQues ..." Link
    Validate user is on "RS Academy" page    ${rsAcademyTitle}
    Validate mentor email present on page    ${mentorEmail}
    Validate user can navigate back to main page    ${mainPageTitle}