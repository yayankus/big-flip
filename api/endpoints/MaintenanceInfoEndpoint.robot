*** Keywords ***
Get Maintenance Info Endpoint
  ${res}=    GET Request    ${ALIAS}   ${MAINTENANCE}    ${HEADERS}=${HEADER}
  [Return]    ${res}
