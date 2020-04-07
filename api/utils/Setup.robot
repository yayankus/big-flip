*** Keywords ***
Generate Authorization
  [Arguments]   ${apiKey}
  Create Session    ${ALIAS}    ${HOST}   verify=true
  ${AUTH}=    Generate Basic Auth     ${apiKey}
  Set Global Variable    ${AUTH}

  Set Default Request Header

Set Default Request Header
  ${HEADER}=   Create Dictionary   ${AUTHORIZATION}=${AUTH}   ${CONTENT_TYPE}=${APPLICATION}
  Set Global Variable    ${HEADER}
