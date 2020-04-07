*** Keywords ***
Get Banks Info Endpoint
  ${res}=    GET Request    ${ALIAS}   ${BANK_INFO}    ${HEADERS}=${HEADER}
  [Return]    ${res}

Get Banks Info By Query Param
  [Arguments]   ${param}
  ${res}=    GET Request    ${ALIAS}   ${BANK_INFO}    ${HEADERS}=${HEADER}   ${PARAMS}=${param}
  [Return]    ${res}

Get Bank Info By Bank Code
  [Arguments]   ${res_body}   ${code}
  ${bank_info}=   Get JSON Object On JSON Array   ${res_body}   ${BANK_CODE}    ${code}
  [Return]    ${bank_info}

Get Bank Info By Bank Name
  [Arguments]   ${res_body}   ${bank_name}
  ${bank_info}=   Get JSON Object On JSON Array   ${res_body}   ${NAME}    ${bank_name}
  [Return]    ${bank_info}

Get Bank Info List By Bank Status
  [Arguments]   ${res_body}   ${bank_status}
  ${bank_info_list}=   Get JSON Array On JSON Array   ${res_body}   ${STATUS}    ${bank_status}
  [Return]    ${bank_info_list}
