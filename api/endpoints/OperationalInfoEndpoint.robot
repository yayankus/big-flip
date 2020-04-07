*** Keywords ***
Get Operational Info Endpoint
  ${res}=    GET Request    ${ALIAS}   ${OPERATIONALS}    ${HEADERS}=${HEADER}
  [Return]    ${res}
