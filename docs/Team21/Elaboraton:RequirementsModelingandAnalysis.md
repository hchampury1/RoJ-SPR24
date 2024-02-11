### An engaging description of the project, including how and why it will add value to extant understanding of the topic.  
Our contribution to the Rails of Justice project will be to add functionality to and polish the Webinar module, which is a crucial component of ACCR’s goal of growth and public outreach. These webinars will largely be in service to lawyers who need Continuing Legal Education (CLE) credits, while at the same time furthering getting the word out about ACCR’s purpose in ending capital punishment and other unfair legal outcomes in our justice system. The completion of this module, fixing bugs, and adding functionality (making enrolling function properly, letting you unenroll, letting you view information on speakers) will make this module much more user friendly, and most importantly, complete and ready to ship to ACCR, who are in need of a usable product to allow their operation to expand.

### A discussion of the social, ethical, economic and real-world issues that must be addressed for the project to deliver value, and how the team will do this.
As a whole ACCR serves a much-needed role where many others would not, primarily since they aid convicted death row inmates. Their webinars allow ACCR to provide training for public defenders on a wide range of topics relating to capital representation and defense. The world of public legal representation spans many different areas of knowledge that defense attorneys must keep up with. ACCR provides free and paid training that gives CLE credits to these attorneys.  The knowledge learned in these webinars gives defense attorneys a better understanding of the capital punishment system and the issues ACCR is working to fix. ACCR makes the distinction of not allowing prosecution attorneys to attend these webinars. This promotes a safe and effective learning environment without prosecutors spying to use ACCR’s tactics against incarcerated people. Our goal is to create an effective webinar module that is both easy to use and provides ACCR with all the tools needed to host their webinars effectively. 

### A description of the feedback you have received from project stakeholders. If you did not follow some requests or suggestions, add explanations for why you did not.
Overall, the project stakeholders responded well to our proposal. They let us know to make sure that registrants signing up for the webinar are able to put their CLE ID, as many of those who sign up are lawyers attending the webinar for that purpose. The ACCR staff also let us know that our idea to be able to export all the webinar data would be incredibly helpful for them. On the flipside, they told us that importing a csv would not be useful, thus we will not add it. As for payment, they requested that we just allow for the link to PayPal, which we can implement. The ACCR staff stressed to all groups that we should aim to have a functional product and make sure we are not too ambitious, which we will keep in mind. Another project stakeholder, Dr. Pulimood provided us feedback when it came to the events feature. ACCR does have other events besides webinars, so we will reflect that in the event calendar. 
	
### Analysis of any ethical or legal concerns posed by the implementation or use of the system.
There are two concerns that our project group must account for and address. The first is that no prosecution attorney can attend the event. While this is out of scope for the semester it is an important feature that ACCR desires in their finished product. While the ACCR staff could go through each registrant and individually do a background check, implementing this into the product itself would save ACCR a lot of time. However, automating such a feature would include the possibility of unintentionally blocking access for those who should have access to the webinars. Instead, it would be best to mesh the two extremes, where the system creates a list of potential prosecution attorneys that are registered and allow the ACCR staff to do individual checks themselves. The other concern for our group stems from our deregister addition to the system. Our intention is that any registered attorney can notify ACCR that they will not make the webinar they signed up for. This can create a big security risk if not implemented properly. Our idea is to have users enter their name and email address, which they previously registered with, into a deregister form similar to the registration form. After this step, there are two options we can take. The first is to automatically delete any registrant that matches those credentials. This is the cause of the security risk as anyone can enter a name and email and if randomly happens to match with someone on the registrant list it will remove them, regardless of if they are who they say they are. Again we can create a list of people who would like to deregister and send that to the ACCR staff, however, this creates more work for them when the system should be making their workload lighter. Currently, there is no better solution to this problem unless the entire registrant system is overhauled to include better identification credentials, which is definitely out of scope and beyond what is possible to finish in the timeframe given.
	
### Descriptive analysis of security and privacy concerns, and how you will address these. 
One major security concern is to recognize that only some users should haveOne major security concern with Web sites is a DDoS Attack. These attacks can bombard the website to the point of denying access to legitimate users. Currently, these targeted attacks are difficult to prevent, but one way of making these attacks less feasible is to make algorithms more efficient and less resource-intensive so that each request requires fewer resources per request. This lessens the chance that a DDoS attack will affect legitimate users.
	Make sure that there is a clear division between the user access and the admin access and maintain the permissions appropriately. Under no circumstances should someone with user access should be able to view the information about other users of a webinar. Only admins should have this privilege. This will maintain security and privacy because other users cannot monitor the activities of other users. Only admins should have the capability to delete and edit information about a webinar. To ensure that admins and users have proper access, there will be targeted testing for those with users access and admin access and those who are not logged in have the correct permission for all pages and actions on those pages.

### Discussion of the requirements for backup and recovery, and how you will provide these.
Our system implements a PostgreSQL database, which holds very important information. PostgreSQL has a command called pg_dump that will create a file with commands that would restore the database to that point (https://www.postgresql.org/docs/current/backup-dump.html). It is a pretty simple way to ensure we have a recovery option in case something happens with our database. As for the Ruby on Rails server, we thankfully have multiple versions of it stored on the remote GitHub which acts as a copy that we can recover a version to. 

### Use Case Decriptions
Use Case: Request Webinar  
Primary actor: CLE Member  
Goal in context: Allow for any user (most likely a CLE member) to request a webinar or a concept for a webinar  
Preconditions: The website is up and running.  
Trigger: The user goes to the "About" tab in the drop-down menu of "Webinars". They fill out the form and click submit.  
Scenario:  
1. User, for example, wants to attend a webinar that they did in the past. 
2. User goes to the RoJ website.
3. User selects "Webinars" dropdown and then "About"
4. User fills out the form correctly. 
5. User submits the form. 
6. ACCR admins get a notification of the request.
Exceptions:  
1. User leaves information blank in the form, gets a message of the error, and will have to fix the mistake before being able to submit.
Priority: Low  
Secondary actors: Any user, not ACCR admins, of RoJ.  
Open issues:  
1. What should go on this form besides name, contact information, and description? 
2. Since email functionality is not working, should a new database be created to keep track of requests for the ACCR admin to view them on RoJ? 

Use Case: Unenroll from webinars  
Primary actor: User  
Goal in context: Allow a user that previously registered for a webinar to submit a form requesting to be deregistered from that specific webinar.  
Preconditions: The website is up and running and the user is already registered for a webinar  
Trigger: On the webinar page, the user clicks the ‘Deregister’ button next to the desired webinar.  
Scenario:  
1. User, for whatever reason, wants to notify ACCR that they cannot attend a webinar they previously registered for.
2. User navigates the Rails of Justice navbar to the Webinar page.
3. User locates the webinar they signed up for and clicks on the ‘Deregister’ button in the same row as the desired webinar. This will navigate the user to the deregister page with the deregister form.
4. User inputs their information into the form (First name, Last name, Email address) and clicks the ‘Submit’ button.
5. The webpage sends a notification to the ACCR staff that a user with the provided credentials has requested to be deregistered from the webinar. 
5. The ACCR staff will manually remove the registrant from the list of registrants of that specific webinar.
Exceptions:  
1. A user inputs information that does not match any registrant on the webinar’s list of registrants.
2. A user inputs information that matches another user, with or without malicious intent.
Priority: Low  
Secondary actors: ACCR Admin  
Open issues:  
1. A user inputs information that matches another user, with or without malicious intent. Must implement some form of identification method or more information required from the user.
2. Currently, the deregister button links to the registration form page. Full implementation will have its own form page.

Use Case: Export Information about Webinar to CSV File  
Primary actor: ACCR Admin  
Goal in context: Create a CSV file that contains the registrant list and information that the ACCR Admin can view and download.  
Preconditions: Website is running, user is logged in with admin access.  
Trigger: “Export as CSV” option is selected on the View Webinar page with desired information selected from the list.  
Scenario:  
1. ACCR admin wants to download webinar information onto their computer to view as an Excel spreadsheet. 
2. Admin logs in to Rails of Justice using the Login button on the site.
3. Admin navigates to “View Webinars” under “Webinars” dropdown menu.
4. Admin can now select “Export as CSV” option and choose what information they want to export.
Exceptions:  
1. Admin does not select any information to export.
Priority: High  
Secondary actors: N/A  
Open issues: Format of CSV file is yet to be determined.  

Use Case: View Requests  
Primary actor: ACCR Admin  
Goal in context: Admin is able to view a request for a webinar and accept or deny it. Will help users who want to see previous webinars again or have other ideas.  
Preconditions: There is a request present and the current user who is viewing the request is an admin  
Trigger: Admin clicks "View Requests" tab   
Scenario:  
1. Admin wants to see if any user created a request.
2. Admin navigates to the Rail of Justice website and hits the "Webinars" drop down menu and then chooses "View Requests". 
3. Admin now sees any requests that were made. 
Exceptions: N/A  
Priority: Medium   
Secondary actors: N/A  
Open issues:   
1. A user will not know the status of the webinar request.
2. Admins cannot comment to give a reason for rejection.

Use Case: View Speaker Information  
Primary Actor(s): User  
Goal in Context: Allow any user to view information about a speaker of a particular webinar.  
Preconditions: There is a webinar with at least one speaker listed  
Trigger: The user clicks on the webinar information page that leads to the information about a speaker.  
Scenario:   
1. A user is unsure about which webinar to attend in a list of upcoming webinars. The user wants more information about a speaker, so the user navigates to the page to find more information about that speaker.
2. A user is curious to learn more about the next few speakers of incoming webinars.
Exceptions:
1. A user tries to gain more information about a speaker that does not exist in the database. In this case, the user will likely receive some error message.
Priority: Medium  
Secondary Actor(s): Users who are not logged in, and admins  
Open Issues  
1. Currently, there is not much information stored about a speaker, so the web site cannot display much information. Hopefully, we can add more information about speakers so that we can display information about the speaker.
2. Ideally, speakers should be able to update information about themselves so that the information is as up-to-date as possible.
