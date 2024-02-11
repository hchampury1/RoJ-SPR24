# Test Case Design

|Functionality Tested|Inputs|Expected Output/Message|Actual Output|
|-|-|-|-|
|Adding New Donation|Donation details and donor details|New donation entry in the in-kind list and leaves user on the donation information page||
|Adding invalid donation|Invalid data input into form (invalid date, character limit exceeded, and/or negative donation amount)|Donation list remains unchanged. User remains on form, with an error message indicating what was invalid about the input.||
|Adding New Donor|Donor details|Donor added successfully to the donor list and leaves user on donor information page||
|Adding invalid donor|Invalid data input into new donor form (invalid email, invalid phone number, or character limit exceeded)|Donor list remains unchanged. User remains on form, with an error message indicating what was invalid about the input.||
|Edit donation|Donation details input into form|Donation successfully updated; user left on donation information page with confirmation message.||
|Edit donor|Donor details input into form.|Donor successfully updated; user left on donor information page with confirmation message.||
|Exporting donation information into tax form|In-Kind donation information pulled from the database|A downloaded pdf to the computer as well as the pdf displayed on screen||
|Editing inputs for PDF|Input fields|New PDF Generated||
|Sorting Donor information by field|UI input (clicking the given header)|Resorted donor information on the display||
|Search|Search term entered; “search” button clicked.|Results filtered to those matching search term||
|Search|Search term that doesn’t match anything is entered; “search” button clicked.|Message reading “no matches” is displayed.||
|Cancel search|User clicks “Cancel search button”|Full list is displayed||
|Restore CSV backup|User clicks “upload and restore CSV backup” button|The backup data is successfully restored.||
