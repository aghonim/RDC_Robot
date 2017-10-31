*** Settings ***
Resource  ../resources/common.robot
Library   String
Library   FakerLibrary
Test Setup  run keywords  Create API Session        login
*** Variables ***
${mydata}                                   {"phoneNumber" : "+09090","address-book" : {"999999999":{"phoneNumber": "7868768","firstname" : "tttttt@gmail.com","lastname" : "test"},"888888888":{"phoneNumber": "141421414","firstname" : "mmmmmm@gmail.com","lastname" : "test"}}}
*** Keywords ***

*** Test Cases ***
Test Add phone book
    [Tags]  Add Phone Book
    Add Phone Book   ${mydata}

Test Find Phone Book
    [Tags]  Find details by number
    Find details by number