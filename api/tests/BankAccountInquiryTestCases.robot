*** Settings ***
Resource          ../config.robot
Resource          ../utils/_UTILS_IMPORT.robot
Resource          ../endpoints/_ENDPOINTS_IMPORT.robot
Suite Setup       Generate Authorization    ${APIKEY}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Post Bank Account Endpoint Without Data
  ${data}=    Set Variable    ${EMPTY}
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${BANK_CODE_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${ACCOUNT_NUMBER_EMPTY}

Post Bank Account Endpoint Without Account Number
  ${data}=    Create Dictionary   ${BANK_CODE}=bca
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${BANK_CODE}]         bca
  Verify String Match   ${res_body}[${ACCOUNT_NUMBER}]    ${NONE}
  Verify String Match   ${res_body}[${ACCOUNT_HOLDER}]    ${EMPTY}
  Verify String Match   ${res_body}[${STATUS}]            ${INVALID_ACCOUNT_NUMBER}

Post Bank Account Endpoint Without Bank Code
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=5465327020
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${BANK_CODE_EMPTY}

Post Bank Account Endpoint With Invalid Bank Code
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=5465327020   ${BANK_CODE}=${INVALID}
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1033
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${INVALID_BANK_CODE}

Post Bank Account Endpoint With Invalid Account Number
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=${INVALID}   ${BANK_CODE}=bca
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${BANK_CODE}]         bca
  Verify String Match   ${res_body}[${ACCOUNT_NUMBER}]    ${INVALID}
  Verify String Match   ${res_body}[${ACCOUNT_HOLDER}]    ${EMPTY}
  Verify String Match   ${res_body}[${STATUS}]            ${INVALID_ACCOUNT_NUMBER}

Post Bank Account Endpoint With Invalid Data
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=${INVALID}   ${BANK_CODE}=${INVALID}
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1020
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_FORMAT}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1033
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${INVALID_BANK_CODE}

Post Bank Account Endpoint With Valid Data
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=5465327020   ${BANK_CODE}=bca
  ${res}=     Post Bank Account Inquiry Endpoint    ${data}

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${BANK_CODE}]         bca
  Verify String Match   ${res_body}[${ACCOUNT_NUMBER}]    5465327020
  Verify String Match   ${res_body}[${ACCOUNT_HOLDER}]    FLIPTECH LENTERA IP PT
  Verify String Match   ${res_body}[${STATUS}]            ${SUCCESS}
