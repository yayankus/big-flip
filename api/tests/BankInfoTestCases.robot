*** Settings ***
Resource          ../config.robot
Resource          ../utils/_UTILS_IMPORT.robot
Resource          ../endpoints/_ENDPOINTS_IMPORT.robot
Suite Setup       Generate Authorization    ${APIKEY}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Get Bank Info By Bank Code
  ${res}=   Get Banks Info Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}

  ${bank_info}=   Get Bank Info By Bank Code    ${res_body}   bca
  Verify String Match   ${bank_info}[${BANK_CODE}]    bca
  Verify String Match   ${bank_info}[${NAME}]         BCA
  Verify String Match   ${bank_info}[${FEE}]          0
  Verify String Match   ${bank_info}[${STATUS}]       ${OPERATIONAL}

Get Bank Info By Bank Name
  ${res}=   Get Banks Info Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}

  ${bank_info}=   Get Bank Info By Bank Name    ${res_body}   Bank MNC Internasional
  Verify String Match   ${bank_info}[${BANK_CODE}]    mnc_internasional
  Verify String Match   ${bank_info}[${NAME}]         Bank MNC Internasional
  Verify String Match   ${bank_info}[${FEE}]          0
  Verify String Match   ${bank_info}[${STATUS}]       ${DISTURBED}

Get Bank Info List By Bank Status
  ${res}=   Get Banks Info Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}

  ${bank_info_list}=   Get Bank Info List By Bank Status    ${res_body}   ${OPERATIONAL}
  ${total_bank_info}=   Get Total Item On List    ${bank_info_list}
  Verify String Match   ${total_bank_info}    5

Get Bank Info By Query Param With Invalid Key-Value Object
  ${params}=    Create Dictionary    ${INVALID}=${INVALID}
  ${res}=   Get Banks Info By Query Param   ${params}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}
  ${total_bank_info}=   Get Total Item On List    ${res_body}
  Verify String Match   ${total_bank_info}    88

Get Bank Info By Query Param With Invalid Key Object
  ${params}=    Create Dictionary    ${INVALID}=bca
  ${res}=   Get Banks Info By Query Param   ${params}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}
  ${total_bank_info}=   Get Total Item On List    ${res_body}
  Verify String Match   ${total_bank_info}    88

Get Bank Info By Query Param With Empty Value Object
  ${params}=    Create Dictionary    ${CODE}=${EMPTY}
  ${res}=   Get Banks Info By Query Param   ${params}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}
  ${total_bank_info}=   Get Total Item On List    ${res_body}
  Verify String Match   ${total_bank_info}    88

Get Bank Info By Query Param With Invalid Value Object
  ${params}=    Create Dictionary    ${CODE}=${INVALID}
  ${res}=   Get Banks Info By Query Param   ${params}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}
  Verify String Match   ${res_body}[${MESSAGE}]    ${BANK_NOT_FOUND}

Get Bank Info By Query Param With Valid Data
  ${params}=    Create Dictionary    ${CODE}=bsm
  ${res}=   Get Banks Info By Query Param   ${params}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=    Get Response Body    ${res}
  Verify String Match   ${res_body}[0][${BANK_CODE}]    bsm
  Verify String Match   ${res_body}[0][${NAME}]         Bank Syariah Mandiri
  Verify String Match   ${res_body}[0][${FEE}]          0
  Verify String Match   ${res_body}[0][${STATUS}]       ${OPERATIONAL}
