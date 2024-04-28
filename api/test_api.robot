*** Settings ***
Library    Collections
Resource    api_shared.robot

*** Test Cases ***
#Test for dictionaries
#    &{dict1}=    Create Dictionary    name=Tom    age=23
#    Log    ${dict1}
#    Run Keyword And Continue On Failure    Dictionary Should Not Contain Key    ${dict1}    name
#    Run Keyword And Warn On Failure    Dictionary Should Contain Key    ${dict1}    name
#    Log Dictionary    ${dict1}

Test to add a new book
    &{book}=    Create Dictionary    name=Learn RF Automation Java    isbn=aaaa    aisle=227000    author=John Doe
    ${response}=    Add a new book    ${book}    200
    Log    ${response.json()}
    Validate key is present    ${response.json()}    Msg
    Validate key is present    ${response.json()}    ID
#    Validate value is not present    ${response.json()}    Book Already Exists
    Validate value is present    ${response.json()}    Book Already Exists
    Validate HTTP status is    200    ${response}