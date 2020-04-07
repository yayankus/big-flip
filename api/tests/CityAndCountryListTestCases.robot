*** Settings ***
Resource          ../config.robot
Resource          ../utils/_UTILS_IMPORT.robot
Resource          ../endpoints/_ENDPOINTS_IMPORT.robot
Suite Setup       Generate Authorization    ${APIKEY}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Get City List Endpoint
  ${res}=   Get City List Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[102]    Kab. Bekasi
  Verify String Match   ${res_body}[8488]   Kab./Kota Lainnya di Papua Barat

Get City By ID
  ${res}=   Get City Endpoint   102

  # Verify Response
  Verify Error Not Found    ${res}

Get Country List Endpoint
  ${res}=   Get Country List Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[100000]   Afghanistan
  Verify String Match   ${res_body}[100252]   Indonesia

Get Country By ID
  ${res}=   Get Country Endpoint   100000

  # Verify Response
  Verify Error Not Found    ${res}

Get City And Country List Endpoint
  ${res}=   Get City And Country List Endpoint

  # Verify Response
  Verify Request Succeed    ${res}
  ${res_body}=   Get Response Body    ${res}

  Verify String Match   ${res_body}[102]      Kab. Bekasi
  Verify String Match   ${res_body}[100252]   Indonesia

Get City And Country By ID
  ${res}=   Get City And Country Endpoint   102

  # Verify Response
  Verify Error Not Found    ${res}

  ${res}=   Get City And Country Endpoint   100252

  # Verify Response
  Verify Error Not Found    ${res}
