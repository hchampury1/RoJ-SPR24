# Remove Call
  Use case: Remove Call
  
  Primary actor: Administrator
  
  Goal in context: To remove a record from the call log when the user asks to delete it
  
  Precondition: Call log has been populated with records and previous calls
  
  Trigger: Administrator receives a request from a user or another administrator to remove a call from the system
  
  Scenario:
  1. Administrator observes call records
  2. Administrator selects a specific call
  3. Administrator presses on the remove icon and confirms that record should be removed from log
    
  Exceptions:
  1. No calls in the log. Calls must be added and entered into the log in order for any to be removed.
  2. Record is flagged as important. Prompts for additional confirmation.
  3. Record is removed. Confirmation page acknowledges the call is no longer in the log.

# Update Call Status
  Use-Case Name: updateCallStatus
  
  Primary Actor: ACCR Admin or Employee
  
  Goal in Context: To update the status of a call of whether or not it was returned.
  
  Preconditions: Primary actor must be logged in to their account on RoJ web application.
  
  Trigger: The primary actor picks an existing call record and updates if it has been returned or not.
  
  Scenario:
  1. Primary actor logs into account on RoJ website.
  2. Primary actor selects the “Call Organizer” tab on the navigation bar to bring up a log of call records.
  3. Primary actor selects the call record they want to edit by updating its status.
  4. The system displays information about the selected call record in an editable manner.
  5. Primary actor changes the status of the call record to state whether or not it has been returned and saves the change(s).
  6. The system verifies that the changes made were saved successfully.
  7. The system displays a confirmation message of the status change(s).
  8. The system returns the log of existing call records with the updated status information of the edited call record.
    
  Exceptions:
  1. Primary actor isn’t logged into their account; won’t see “Call Organizer” tab and therefore can’t update the status of a call record
  2. The system fails to save the changes of the updated status of the selected call record
  3. The system displays an error message explaining that the changes could not be saved.
  4. The system returns to the editable form of the call record.
  5. Primary actor makes the necessary changes and saves them again.

# Add Call
  Use-Case Name: addCall
  
  Primary Actor: ACCR Admin or Employee
  
  Goal in Context: To add a new call entry to the call log 
  
  Preconditions: Primary actor must be logged in to their account on RoJ web application.
  
  Trigger: The primary actor decides to add a new call entry by selecting the “Add Call” button or selecting the “Add Call” tab in the “Call Organizer” dropdown
  
  Scenario:
  1. Primary actor logs into RoJ application
  2. Primary actor selects “Add Call” tab in the “Call Organizer” dropdown or selects “Call Log” in the “Call Organizer” dropdown and hits “Add Call” button
  3. Primary actor fills out “Add Call” form and hits submit button
  4. The system displays a confirmation message that the call was added successfully.
  5. Primary actor is brought to call log where they can view there newly added call entry along with the rest of the existing call entries
  
  Exceptions:
  1. Primary actor is not logged in: Primary actor logs into web application
  2. Data inputted in form is invalid(Invalid message displayed): Primary actor fixes the validity of their inputs

# Edit Call
  Use-Case Name: EditCall
  
  Primary Actor: ACCR Employee
  
  Goal in Context: The ACCR employee edits an existing call record in the system.
  
  Preconditions: The admin must be logged in and authorized to edit call records.
  
  Trigger: The admin selects an existing call record and chooses the option to edit.
  
  Scenario:
  1. The system displays a list of existing call records.
  2. AACR employee selects the call record they wish to edit.
  3. The system displays the details of the selected call record in an editable form.
  4. The AACR employee makes the desired changes to the call record.
  5. The AACR employee saves the changes.
  6. The system verifies that the changes have been saved successfully.
  7. The system displays a confirmation message to the admin.
  8. The AACR employee clicks on the OK button to dismiss the confirmation message.
  9. The system returns to the list of call records.
    
  Exceptions:
  1. The ACCR employee selects a call record that is locked and cannot be edited:
  2. The system displays an error message explaining that the selected call record is locked and cannot be edited.
  3. The employee clicks on the OK button to dismiss the error message.
  4. The system returns to the list of call records.
  5. The ACCR employee fails to save the changes made to the call record:
  6. The system displays an error message explaining that the changes could not be saved.
  7. The employee clicks on the OK button to dismiss the error message.
  8. The system returns to the editable form of the call record with the changes made by the employee still visible.
  9. The ACCR employee makes the necessary changes and saves them again.

# Search Call Data
  Use Case Name: Search call data
  
  Primary Actor: ACCR employee
  
  Goal in context: ACCR employee wants to view all missed calls or search for a specific call
  
  Preconditions: ACCR employee is logged in after entering account and password
  
  Trigger: ACCR employee will click “Call Organizer” in the navbar
  
  Scenario:
  1. ACCR employee observes options on navbar
  2. ACCR employee clicks on Call Organizer in navbar
  3. ACCR can input into the search bar a specific to filter the table
  
  Exceptions:
  1. No phone numbers show up: The searched phone number is not in database
  2. User account logged in: ACCR employee must be signed in
