*** Settings ***
Library  Browser

*** Variables ***
${URL}  https://duckduckgo.com/
${TEXT}  DuckDuckGo

*** Test Cases ***
Run Page Check
    Check if ${URL} contains ${TEXT}

*** Keywords ***
Check if ${URL} contains ${TEXT}
    Log  Check if ${URL} contains "${TEXT}"  console=True
    New Browser  chromium
    New Page  ${URL}
    Wait Until Network Is Idle
    ${passed}  Run Keyword And Return Status  Get Element  //*[contains(text(),'${TEXT}')]
    Should be True  ${passed}