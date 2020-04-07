*** Keywords ***
Get Balance Endpoint
  ${res}=    GET Request    ${ALIAS}   ${BALANCE}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get Balance Account
  ${res}=   Get Balance Endpoint
  ${res_body}=   Get Response Body    ${res}
  ${total}=   Set Variable    ${res_body}[${BALANCES}]
  [Return]    ${total}
