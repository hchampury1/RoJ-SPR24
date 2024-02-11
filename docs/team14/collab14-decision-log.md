# Decision Log
- A decision that we made was to just read each file, have no error checking, and add it to the database or repeat entry checking which leads to technical debt. 
- We decided to have the mass csv upload feature and the form on the same webpage. 
- When reading the CSV file, the date has to be in the exact format of YYYY-MM-DD, which can lead to certain entries not getting uploaded without the user realizing. 
- The decision to add the template_file.csv to the webpage was also done to make the process easier for the ACCR staff.
