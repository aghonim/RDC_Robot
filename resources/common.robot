*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     HttpLibrary.HTTP
Library     Collections

*** Variables ***
###########################
#APIs URIs
${Post PhoneBook}                           /base/crd/incoming_address_book/1.json
${Get Result}                               /base/crd/result_directory/.json
${Get Token}                                /auth/base?email=worker%40orange.com&password=12345678&base=crd
${Get Profile}                              /base/crd/result_directory/.json
############################
${baseurl}                                  https://io.datasync.orange.com
${Token}                                    ?auth=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MDk0NTEyNzcsInAiOiJhZG1pbiIsImlhdCI6MTUwOTM2NDg3NywiZCI6eyJ1aWQiOiJuc2FkbWluOjAifX0.7BO3KyuhwqxdCtAg7dG_A3kSLANyafd8808rkG7Yp18
&{headers}                                  content-type=application/json       provider=password
${proxy}                                    proxies=http://proxypac.si.francetelecom.fr:8080/
############ DB ##########
${Namespace}                                test
*** Keywords ***
Create API Session
    create session  rdapisession  ${baseurl}

login
    ${resp}     get request      alias=rdapisession    uri=/auth/base?email=worker%40orange.com&password=12345678&base=crd
    log    ${resp.json()['token']}
    set global variable  ${auth_token}  ${resp.json()['token']}
    set global variable  ${UID}  ${resp.json()['uid']}

Add Phone Book
    [Arguments]  ${phoneBookData}
    log  ${phoneBookData}
    ${resp}      post request  alias=rdapisession   uri=${Post PhoneBook}?auth=${auth_token}    data=${phoneBookData}   headers=${headers}
    log  ${phoneBookData}
    log  ${resp.text}
    [Return]  ${resp}

Find details by number
    set to dictionary  ${headers}       uid     ${UID}
    log dictionary  ${headers}
    ${resp}      get request  alias=rdapisession     uri=${Get Profile}      headers=${headers}
    log  ${resp.text}
