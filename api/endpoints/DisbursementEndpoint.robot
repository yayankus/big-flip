*** Keywords ***
Get Disbursement List Endpoint
  ${res}=    GET Request    ${ALIAS}   ${DISBURSEMENT}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get Disbursement Endpoint
  [Arguments]   ${id}
  ${res}=    GET Request    ${ALIAS}   ${DISBURSEMENT}/${id}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get Disbursement Queue Endpoint
  [Arguments]   ${id}
  ${res}=    GET Request    ${ALIAS}   ${DISBURSEMENT}/${id}/${QUEUE}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Post Disbursement Endpoint
  [Arguments]   ${payload}
  ${res}=    POST Request    ${ALIAS}   ${DISBURSEMENT}    ${HEADERS}=${HEADER}   ${DATA}=${payload}
  [Return]    ${res}
