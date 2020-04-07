*** Keywords ***
Get City List Endpoint
  ${res}=    GET Request    ${ALIAS}   ${CITY_LIST}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get City Endpoint
  [Arguments]   ${id}
  ${res}=    GET Request    ${ALIAS}   ${CITY_LIST}/${id}    ${HEADERS}=${HEADER}
  [Return]    ${res}
