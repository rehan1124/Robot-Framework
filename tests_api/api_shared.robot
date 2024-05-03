*** Settings ***
Documentation    Contains shared keywords for API
Library    Collections
Library    FakerLibrary
Library    RequestsLibrary

*** Variables ***
${api_base_url}    https://rahulshettyacademy.com
${add_new_book_ep}    Library/Addbook.php
${get_book_details}    Library/GetBook.php
${delete_book}    Library/DeleteBook.php

*** Keywords ***
Add a new book
    [Arguments]    ${json_payload}    ${http_code}
    Log    ${json_payload}
    ${response}=    Run Keyword And Continue On Failure    POST    url=${api_base_url}/${add_new_book_ep}    json=${json_payload}    expected_status=${http_code}
    Log    POST Response body: ${response.json()}
    Return From Keyword    ${response}
    
Get book details by ID
    [Arguments]    ${book_id}
    Log    Get book details for: ${book_id}
    ${response}=    Run Keyword And Continue On Failure    GET    url=${api_base_url}/${get_book_details}    params=ID=${book_id}
    Log    GET Response body: ${response.json()[0]}
    Return From Keyword    ${response}

Delete book by ID
    [Arguments]    ${json_payload}    ${http_code}
    Log    Deleting book with ID: ${json_payload}[ID]
    ${response}=    Run Keyword And Continue On Failure    POST    url=${api_base_url}/${delete_book}    json=${json_payload}    expected_status=${http_code}
    Log    POST Response body: ${response.json()}
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
    
Validate given 2 string values are equal
    [Arguments]    ${string1}    ${string2}
    Log Many    Comparing strings:    ${string1}    ${string2}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${string1}    ${string2}