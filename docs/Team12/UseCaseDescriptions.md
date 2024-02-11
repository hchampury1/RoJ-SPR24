Use case #1: Enter Personal Information
- Primary actor: Customer
- Goals in Context: The customer enters their personal information to attend meetings/webinars in the ROJ application
- Preconditions: 
  - The customer must first navigate to the ROJ application. 
  - The customer must select the meeting/webinar they wish to attend. 
- Scenario: 
  - The customer selects the meeting/webinar they want to attend
  - ROJ application prompts the customer to enter their personal information such as first and last name, email address, occupation, county, etc. 
  - The customer confirms that the information is correct
- Exceptions:
  - The application will not register the customer for the meeting or webinar if they simply click the “submit’ button without first entering any personal information

Use case #2: Clicks on PayPal Button
- Primary actor: Customer
- Goals in Context: The customer wants to pay for the selected meeting/webinar registration through PayPal
- Preconditions: 
  - Customer has selected the desired webinar/meeting to attend
  - Customer has already entered their personal information in the payment form
- Scenario: 
  - Customer clicks on PayPal button on the webinar registration page
  - System redirects the customer to PayPal payment gateway
  - Customer login into their Paypal account and manually types the total amount for the webinar/meeting they wish to attend
- Exceptions: 
  - If the customer doesn’t have a valid PayPal account, the payment cannot be processed

Use case #3: Clicks on Submit Form Button 
- Primary actor: Customer
- Goals in Context: The goal is to ensure that the customer's payment is successfully processed and confirm the registration
- Preconditions: 
  - Customer has clicked on the PayPal button and completed the payment process
- Scenario: 
  - After the user has clicked on the PayPal button and completed the payment process they will be redirected back to the registration page
  - The customer can click on the “submit” button to confirm the payment and their registration
  - If the payment was successful and the user clicks on “submit” button, then their registration is confirmed
- Exceptions: 
  - If the payment was not successful then the user cannot click on the submit button for their registration to get confirmed

Use case #4: View payment history on existing database
- Primary actor: ACCR Staff
- Goals in Context: This use case aims to give admins a quick and effective way to monitor the payment history of clients who participated in webinars and meetings. The admins can use this information to follow clients' payment statuses and address any issues with payments.
- Preconditions: 
  - The user is an admin with authorized access to the database.
  - Payment details for webinars and meetings are stored in a database.
- Scenario:
  - After logging in, the administrator goes to the module that contains the payment history information.
  - The program pulls payment information out of the database and presents it in an intuitive manner.
  - The admin can view the payment details such as amount paid, customer name, payment method, and etc.,
- Exceptions:
  - The system displays an access denied notice if the user is not an authorized admin.
