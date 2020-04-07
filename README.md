# Automation Test using RobotFramework

This automation test script using RobotFramework with builtin `Request Library`

## Setup
### Install RobotFramework
Since RobotFramework based on Python, make sure it already installed.
On this project using `python 3.7.3`

### Initiate Virtual Environment
```bash
virtualenv -p python3 env
```

### Activate Virtual Environment
```bash
source env/bin/activate
```
### Install Library Dependencies
Run this script for install RobotFramework and libraries
```bash
pip install -r requirement.txt
```
## Usage
Run this script for running test based on 'Test Case Name'
```bash
robot -t "[TEST CASE NAME]" [TEST FILE NAME]
```

Run this script for running all test on suite
```bash
robot [TEST FILE NAME]
```
e.g : robot api/tests/SampleTest.robot

After finished, it will generate `Output File`, `Log File` and `Report File`.

## Notes
Since we don't want to expose our `APIKEY`, Please Update `${APIKEY}` variable using your Valid APIKEY on `api/config.robot` or you can parse the APIKEY on RobotFramework command line using this command
```bash
robot -v APIKEY:"[YOUR APIKEY]" [TEST FILE NAME]
```
