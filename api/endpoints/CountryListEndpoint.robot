*** Keywords ***
Get Country List Endpoint
  ${res}=    GET Request    ${ALIAS}   ${COUNTRY_LIST}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get Country Endpoint
  [Arguments]   ${id}
  ${res}=    GET Request    ${ALIAS}   ${COUNTRY_LIST}/${id}    ${HEADERS}=${HEADER}
  [Return]    ${res}
