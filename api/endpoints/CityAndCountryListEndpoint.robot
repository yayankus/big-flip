*** Keywords ***
Get City And Country List Endpoint
  ${res}=    GET Request    ${ALIAS}   ${CITY_COUNTRY_LIST}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get City And Country Endpoint
  [Arguments]   ${id}
  ${res}=    GET Request    ${ALIAS}   ${CITY_COUNTRY_LIST}/${id}    ${HEADERS}=${HEADER}
  [Return]    ${res}
