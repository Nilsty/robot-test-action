*** Settings ***
Library  SeleniumLibrary

Test Setup      Start Headless Browser
Test Teardown   Close Browser

*** Variables ***
@{chrome_arguments}    --disable-infobars    --headless
...    --disable-gpu   --no-sandbox   --window-size=1920,1080
${URL}  https://duckduckgo.com/
${TEXT}  DuckDuckGo

*** Test Cases ***
Run Page Check
    [Documentation]  This test will check if a certain text 
    ...  can be found on a certain page.
    Check if ${URL} contains ${TEXT}

*** Keywords ***
Check if ${URL} contains ${TEXT}
    Log  Check if ${URL} contains "${TEXT}"  console=True
    Wait Until Page Contains Element  //*[contains(text(),'${TEXT}')]

Start Headless Browser
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}   add_argument    headless
    Call Method    ${chrome_options}   add_argument    disable-gpu
    ${options}=     Call Method     ${chrome_options}    to_capabilities
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${URL}

Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${option}    IN    @{chrome_arguments}
        Call Method    ${options}    add_argument    ${option}
    END
    [Return]    ${options}

