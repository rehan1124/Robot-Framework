*** Settings ***
Documentation    Contains shared keywords for API
Library    RequestsLibrary
Library    Collections

*** Variables ***
${api_base_url}    https://rahulshettyacademy.com
${add_new_book_ep}    Library/Addbook.php

*** Keywords ***
Add a new book
    [Arguments]    ${json_payload}    ${http_code}
    Log    ${json_payload}
    ${response}=    Run Keyword And Continue On Failure    POST    url=${api_base_url}/${add_new_book_ep}    json=${json_payload}    expected_status=${http_code}
    Return From Keyword    ${response}
    
Validate key is present
    [Arguments]    ${dict}    ${key}
    Run Keyword And Continue On Failure    Dictionary Should Contain Key    ${dict}    ${key}
    
Validate value is present
    [Arguments]    ${dict}    ${value}
    Run Keyword And Continue On Failure    Dictionary Should Contain Value    ${dict}    ${value}
    
Validate value is not present
    [Arguments]    ${dict}    ${value}
    Run Keyword And Continue On Failure    Dictionary Should Not Contain Value    ${dict}    ${value}
    
Validate HTTP status is
    [Arguments]    ${http_code}    ${response}
    Run Keyword And Continue On Failure    Status Should Be    ${http_code}    ${response}