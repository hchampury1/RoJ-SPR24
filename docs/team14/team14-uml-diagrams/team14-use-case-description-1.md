# Team 14 - Use Case 1 Description

## Use case
CSV file upload
## Primary actor
ACCR staff

## Goal in context
To upload a csv file with populated data to update database

## Preconditions
System is logged into by the ACCR staff

## Trigger
The ACCR staff press the “upload csv” button on the Pro bono tracker page

## Scenario
- ACCR staff will log in as an admin
- ACCR staff navigate to the pro bono tracker page
- ACCR staff click the “upload csv”
- ACCR staff is prompted that the data was successfully uploaded to the database

## Exceptions
- The website is not working because the server is down.
- Username or Password is incorrect(ACCR staff is prompted to enter password again)
- Password is not recognized. Monitoring and response systems must be contacted to reprogram passwords.
	
## Priority
Useful if implemented

## When available
First increment

## Frequency of use
Once in a while

## Channel to actor
Via button on the user interface

## Secondary actor
Database

## Channels to secondary actor:
Database: code 

## Open issues:
- What should be done if the file is not valid and does not match the database?
- What if it is not a csv file?
