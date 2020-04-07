*** Keywords ***
Post Bank Account Inquiry Endpoint
  [Arguments]   ${payload}
  ${res}=    POST Request    ${ALIAS}   ${BANK_ACCOUNT}    ${HEADERS}=${HEADER}   ${DATA}=${payload}
  [Return]    ${res}
