*** Keywords ***
Verify String Match
  [Arguments]   ${actual}   ${expected}
  Should Be Equal As Strings    ${actual}    ${expected}

Verify String Contain
  [Arguments]   ${actual}   ${expected}
  Should Contain    ${actual}    ${expected}

Get JSON Object On JSON Array
  [Arguments]   ${json_array}   ${key}    ${value}
  :FOR    ${item}   IN    @{json_array}
  \   Return From Keyword If    '${item}[${key}]'=='${value}'    ${item}

Get JSON Array On JSON Array
  [Arguments]   ${json_array}   ${key}    ${value}
  @{bank_info_list}=    Create List

  :FOR    ${item}   IN    @{json_array}
  \     Run Keyword If    '${item}[${key}]'=='${value}'
  ...   Append To List    ${bank_info_list}    ${item}
  [Return]    @{bank_info_list}

Get Total Item On List
  [Arguments]   ${list}
  ${total}=   Evaluate    len($list)
  [Return]    ${total}
