*** Settings ***
Library    Collections
Library    FakerLibrary
Resource    api_shared.robot

*** Test Cases ***
#Test for dictionaries
#    &{dict1}=    Create Dictionary    name=Tom    age=23
#    Log    ${dict1}
#    Run Keyword And Continue On Failure    Dictionary Should Not Contain Key    ${dict1}    name
#    Run Keyword And Warn On Failure    Dictionary Should Contain Key    ${dict1}    name
#    Log Dictionary    ${dict1}

Validate user is able to add new book
    [Tags]    API    ADD_BOOKS
    ${book_author}=    FakerLibrary.Name
    ${book_name}=    Catenate    Book by    ${book_author}
    ${book_isbn}=    FakerLibrary.Isbn 10
    ${book_aisle}=    FakerLibrary.Random Number    digits=6
    &{book}=    Create Dictionary    name=${book_name}    isbn=${book_isbn}    aisle=${book_aisle}    author=${book_author}
    ${response}=    Add a new book    ${book}    200
    Validate key is present    ${response.json()}    Msg
    Validate key is present    ${response.json()}    ID
    Validate value is present    ${response.json()}    successfully added
    ${book_id}    Catenate    SEPARATOR=    ${book_isbn}    ${book_aisle}
    Validate value is present    ${response.json()}    ${book_id}

Validate user is able to get book details
    [Tags]    API    GET_BOOK
    ${book_author}=    FakerLibrary.Name
    ${book_name}=    Catenate    Book by    ${book_author}
    ${book_isbn}=    FakerLibrary.Isbn 10
    ${book_aisle}=    FakerLibrary.Random Number    digits=6
    &{book}=    Create Dictionary    name=${book_name}    isbn=${book_isbn}    aisle=${book_aisle}    author=${book_author}
    ${response}=    Add a new book    ${book}    200
    ${book_id}    Catenate    SEPARATOR=    ${book_isbn}    ${book_aisle}
    ${response}=    Get book details by ID    ${book_id}
    Validate value is present    ${response.json()[0]}    ${book_author}
    Validate value is present    ${response.json()[0]}    ${book_name}
    Validate value is present    ${response.json()[0]}    ${book_isbn}
    ${book_aisle_str}=    Convert To String    ${book_aisle}
    Validate value is present    ${response.json()[0]}    ${book_aisle_str}

Validate user is able to delete the book
    [Tags]    API    DELETE_BOOK
    ${book_author}=    FakerLibrary.Name
    ${book_name}=    Catenate    Book by    ${book_author}
    ${book_isbn}=    FakerLibrary.Isbn 10
    ${book_aisle}=    FakerLibrary.Random Number    digits=6
    &{book}=    Create Dictionary    name=${book_name}    isbn=${book_isbn}    aisle=${book_aisle}    author=${book_author}
    ${response}=    Add a new book    ${book}    200
    ${book_id}    Create Dictionary    ID=${response.json()}[ID]
    ${response}=    Delete book by ID    ${book_id}    200
    Validate given 2 string values are equal    ${response.json()}[msg]    book is successfully deleted