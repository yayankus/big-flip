*** Settings ***
Library   RequestsLibrary
Library   Collections

Library   ../scripts/auth_generator.py

*** Variables ***
${HOST}   https://sandbox.flip.id/api/v2
${ALIAS}  API

# List Base URL
${DISBURSEMENT}         /disbursement
${GENERAL}              /general
${BANK_ACCOUNT}         ${DISBURSEMENT}/bank-account-inquiry
${CITY_LIST}            ${DISBURSEMENT}/city-list
${CITY_COUNTRY_LIST}    ${DISBURSEMENT}/city-country-list
${COUNTRY_LIST}         ${DISBURSEMENT}/country-list
${BALANCE}              ${GENERAL}/balance
${BANK_INFO}            ${GENERAL}/banks
${MAINTENANCE}          ${GENERAL}/maintenance
${OPERATIONALS}         ${GENERAL}/operational

# Data Credential
${APIKEY}   Input Your API Key Here
