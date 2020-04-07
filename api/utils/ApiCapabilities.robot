*** Keywords ***
Get Response Body
  [Arguments]   ${res}
  ${content}=   Evaluate     $res.json()
  [Return]      ${content}

Verify Status Code
  [Arguments]   ${res}    ${expected}
  Status Should Be    ${expected}   ${res}

Verify Request Succeed
  [Arguments]   ${res}
  Request Should Be Successful    ${res}

Verify Error Not Found
  [Arguments]   ${res}
  Verify Status Code    ${res}    ${404}

  ${res_body}=   Get Response Body    ${res}
  Verify String Match   ${res_body}[${NAME}]      Not Found
  Verify String Match   ${res_body}[${MESSAGE}]   ${PAGE_NOT_FOUND}
  Verify String Match   ${res_body}[${STATUS}]    ${404}
