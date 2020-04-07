*** Settings ***
Resource          ../config.robot
Resource          ../utils/_UTILS_IMPORT.robot
Resource          ../endpoints/_ENDPOINTS_IMPORT.robot
Suite Setup       Generate Authorization    ${APIKEY}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Post Disbursement Without Required Data
  ${data}=    Set Variable    ${EMPTY}
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${BANK_CODE_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][2][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][2][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][2][${MESSAGE}]     ${AMOUNT_EMPTY}

Post Disbursement With Only Account Number
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=0
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${BANK_CODE_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${AMOUNT_EMPTY}

Post Disbursement With Only Bank Code
  ${data}=    Create Dictionary   ${BANK_CODE}=bca
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${AMOUNT_EMPTY}

Post Disbursement With Only Amount
  ${data}=    Create Dictionary   ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_EMPTY}

  Verify String Match   ${res_body}[${ERRORS}][1][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][1][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][1][${MESSAGE}]     ${BANK_CODE_EMPTY}

Post Disbursement Without Account Number
  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_EMPTY}

Post Disbursement Without Bank Code
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=0    ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${BANK_CODE_EMPTY}

Post Disbursement Without Amount
  ${data}=    Create Dictionary   ${ACCOUNT_NUMBER}=0    ${BANK_CODE}=bca
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1001
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${AMOUNT_EMPTY}

Post Disbursement With Invalid Bank Code
  ${data}=    Create Dictionary   ${BANK_CODE}=${INVALID}    ${ACCOUNT_NUMBER}=0    ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${BANK_CODE}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1033
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${INVALID_BANK_CODE}

Post Disbursement With Invalid Account Number
  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=${INVALID}    ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1020
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_FORMAT}

  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=00000000000000000000    ${AMOUNT}=10000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${ACCOUNT_NUMBER}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1025
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${ACCOUNT_NUMBER_INVALID}

Post Disbursement With Invalid Amount
  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=5465327020    ${AMOUNT}=${INVALID}
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1020
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${AMOUNT_NUMBER_FORMAT}

  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=5465327020    ${AMOUNT}=9999
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1021
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${MINIMUM_TRANSFER}

  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=5465327020    ${AMOUNT}=1000000001
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${VALIDATION_ERROR}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1022
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${MAXIMUM_TRANSFER}

Post Disbursement With Insufficient Balance
  ${data}=    Create Dictionary   ${BANK_CODE}=bca    ${ACCOUNT_NUMBER}=5465327020    ${AMOUNT}=30000000
  ${res}=     Post Disbursement Endpoint    ${data}

  # Verify Response
  Verify Status Code    ${res}    422
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[${CODE}]    ${BALANCE_INSUFFICIENT}

  # Verify Detail Error
  Verify String Match   ${res_body}[${ERRORS}][0][${ATTRIBUTE}]   ${AMOUNT}
  Verify String Match   ${res_body}[${ERRORS}][0][${CODE}]        1035
  Verify String Match   ${res_body}[${ERRORS}][0][${MESSAGE}]     ${INSUFFICIENT_BALANCE}

Post Disbursement With Valid Data
  ${amounts}=       Set Variable    ${10000}
  ${bank}=          Set Variable    bca
  ${account_num}=   Set Variable    5465327020

  ${data}=    Create Dictionary   ${BANK_CODE}=${bank}    ${ACCOUNT_NUMBER}=${account_num}    ${AMOUNT}=${amounts}
  ${res}=     Post Disbursement Endpoint    ${data}
  ${res_body}=   Get Response Body    ${res}

  # Verify Response
  Verify Request Succeed    ${res}
  Verify String Match   ${res_body}[${USER_ID}]           73
  Verify String Match   ${res_body}[${AMOUNT}]            ${amounts}
  Verify String Match   ${res_body}[${STATUS}]            ${PENDING}
  Verify String Match   ${res_body}[${BANK_CODE}]         ${bank}
  Verify String Match   ${res_body}[${ACCOUNT_NUMBER}]    ${account_num}
  Verify String Match   ${res_body}[${RECIPIENT_NAME}]    FLIPTECH LENTERA IP PT
