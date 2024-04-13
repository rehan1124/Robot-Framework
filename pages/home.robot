*** Settings ***
Documentation    Keywords for Home page or page that comes after user login
Library    SeleniumLibrary
Library    Collections
Library    Screenshot

*** Variables ***
${checkout_xpath}    xpath://a[contains(text(), 'Checkout')]
${item_cards}    css:app-card-list h4[class='card-title']
${navbar}    xpath://div[@id='navbarResponsive']
${mentor_email_css}    css:p[class*='red'] a[href*='mailto']

*** Keywords ***
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