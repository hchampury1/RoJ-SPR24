# frozen_string_literal: true

require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create the global configuration
# create! makes the object and automatically saves it to the database
# the ! means that if something goes wrong and cannot save, throw an exception

AppConfig.create!(name: 'ACCR', logo_url: 'hhhhhhh')


# Seed States
states_data = [
  { name: "Alabama", abbreviation: "AL" },
  { name: "Alaska", abbreviation: "AK" },
  { name: "Arizona", abbreviation: "AZ" },
  { name: "Arkansas", abbreviation: "AR" },
  { name: "California", abbreviation: "CA" },
  { name: "Colorado", abbreviation: "CO" },
  { name: "Connecticut", abbreviation: "CT" },
  { name: "Delaware", abbreviation: "DE" },
  { name: "Florida", abbreviation: "FL" },
  { name: "Georgia", abbreviation: "GA" },
  { name: "Hawaii", abbreviation: "HI" },
  { name: "Idaho", abbreviation: "ID" },
  { name: "Illinois", abbreviation: "IL" },
  { name: "Indiana", abbreviation: "IN" },
  { name: "Iowa", abbreviation: "IA" },
  { name: "Kansas", abbreviation: "KS" },
  { name: "Kentucky", abbreviation: "KY" },
  { name: "Louisiana", abbreviation: "LA" },
  { name: "Maine", abbreviation: "ME" },
  { name: "Maryland", abbreviation: "MD" },
  { name: "Massachusetts", abbreviation: "MA" },
  { name: "Michigan", abbreviation: "MI" },
  { name: "Minnesota", abbreviation: "MN" },
  { name: "Mississippi", abbreviation: "MS" },
  { name: "Missouri", abbreviation: "MO" },
  { name: "Montana", abbreviation: "MT" },
  { name: "Nebraska", abbreviation: "NE" },
  { name: "Nevada", abbreviation: "NV" },
  { name: "New Hampshire", abbreviation: "NH" },
  { name: "New Jersey", abbreviation: "NJ" },
  { name: "New Mexico", abbreviation: "NM" },
  { name: "New York", abbreviation: "NY" },
  { name: "North Carolina", abbreviation: "NC" },
  { name: "North Dakota", abbreviation: "ND" },
  { name: "Ohio", abbreviation: "OH" },
  { name: "Oklahoma", abbreviation: "OK" },
  { name: "Oregon", abbreviation: "OR" },
  { name: "Pennsylvania", abbreviation: "PA" },
  { name: "Rhode Island", abbreviation: "RI" },
  { name: "South Carolina", abbreviation: "SC" },
  { name: "South Dakota", abbreviation: "SD" },
  { name: "Tennessee", abbreviation: "TN" },
  { name: "Texas", abbreviation: "TX" },
  { name: "Utah", abbreviation: "UT" },
  { name: "Vermont", abbreviation: "VT" },
  { name: "Virginia", abbreviation: "VA" },
  { name: "Washington", abbreviation: "WA" },
  { name: "West Virginia", abbreviation: "WV" },
  { name: "Wisconsin", abbreviation: "WI" },
  { name: "Wyoming", abbreviation: "WY" }
]


states_data.each do |state|
  State.find_or_create_by!(name: state[:name], abbreviation: state[:abbreviation])
end


job_types = [
  { name: 'Public Defense - Full Time', fee: 0.00 },
  { name: 'Public Defense - Part Time', fee: 0.00 },
  { name: 'Conflict/Contract Counsel', fee: 5.00 },
  { name: 'Private Attorney', fee: 25.00 },
  { name: 'Mitigation Specialist', fee: 0.00 },
  { name: 'Criminal Defense Investigator', fee: 0.00 },
  { name: 'Other', fee: 0.00 }
]

job_types.each do |job_type|
  JobType.find_or_create_by!(name: job_type[:name], fee: job_type[:fee])
end



if Rails.env.development?

  # We're in a development mode, so making fake, insecure data is fine
  # Create two user profiles, admin and unprivledged user
  # Right now, there is no difference between the accounts
  # If your project needs it, add a boolean field to user for administrator
  admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', first_name: 'Addy', last_name: 'Minesoda', role: 1)
  user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', first_name: 'Jane', last_name: 'Doe', role: 0)

  # donor1 = Donor.create!(donor_name: 'Test', id: 0)

=begin
  # Create example donations:
  Donation.create!(guid: 'feba8c26-cc01-4369-9e9b-30a09643fc8c', date: '2022-10-26 01:00:00 UTC ', hours: 1.0, description: 'Description A: lorem ipsum')
  Donation.create!(guid: '4c971444-62db-4125-a33a-957c56ce9598', date: '2022-10-26 01:00:00 UTC ', hours: 1.0, description: 'Description B: lorem ipsum')

  #Create example lawyers:
  Staff.create!(guid: 'feba8c26-cc01-4369-9e9b-30a09643fc8c', lawyername: 'Lawyer A')
  Staff.create!(guid: '4c971444-62db-4125-a33a-957c56ce9598', lawyername: 'Lawyer B')

  # Create example cases:
  Case.create!(guid: 'feba8c26-cc01-4369-9e9b-30a09643fc8c', caseaddress: 'Address A', casename: 'Case Name A')
  Case.create!(guid: '4c971444-62db-4125-a33a-957c56ce9598', caseaddress: 'Address B', casename: 'Case Name B')
=end

 #admin2 = User.create!(email: 'admin2@example.com', password: 'password!', password_confirmation: 'password!', first_name: 'Addy', last_name: 'Minesoda', role: 1)
  #user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', first_name: 'Jane', last_name: 'Doe', role: 0)


  #Test registrant
  # firstReg = Registrant.create!(firstName: 'John', lastName: 'Doe', email: 'testemail@gmail.com', occupation: 'defense attorney', wantsCredit: true, paid: false)

  # For development purposes, we have created 5 possible projects to choose from
  project1 = Project.create!(name: 'Court Hearings')
  project2 = Project.create!(name: 'Appearances')
  project3 = Project.create!(name: 'Training')
  project4 = Project.create!(name: 'Consultations')
  project5 = Project.create!(name: 'Case Work')


  #Creating donations
  Donation.create!(guid: 'feba8c26-cc01-4369-9e9b-30a09643fc8c', lawyername: 'Lawyer A', caseaddress: 'Training', name: 'Case Name A', date: '2022-10-26 01:00:00 UTC ', hours: 1.0, fees: 35.00, description: 'Description A: lorem ipsum', user_id: admin.id, project_id: project1.id)
  Donation.create!(guid: '4c971444-62db-4125-a33a-957c56ce9598', lawyername: 'Lawyer B', caseaddress: 'Court', name: 'Case Name B', date: '2022-10-26 01:00:00 UTC ', hours: 1.0, fees: 25.00, description: 'Description B: lorem ipsum', user_id: admin.id, project_id: project1.id)
  

  worklog = [

    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project2.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project3.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project4.id, desc_summary: 'Helped Fill Form', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project4.id, desc_summary: 'Met with Client', hours: 8.5, fee: 337.77, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Helped Fill Form', hours: 1, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Met with Client', hours: 2.5, fee: 41.22, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Met with Client', hours: 2.5, fee: 41.22, date: '2022-04-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Met with Client', hours: 2.5, fee: 41.22, date: '2022-03-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Met with Client', hours: 2.5, fee: 41.22, date: '2022-05-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project5.id, desc_summary: 'Met with Client', hours: 2.5, fee: 41.22, date: '2022-04-03 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: user.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 0.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 1.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 2, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 5.5, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 6, fee: 337.50, date: '2013-02-02 01:00:00 UTC '},
    {user_id: admin.id, project_id: project1.id, desc_summary: 'Send Confirmation Emails', hours: 8, fee: 337.50, date: '2013-02-02 01:00:00 UTC '}
  ]

  # worklogs.each {|attributes| Worklog.create!(attributes)}


  csv_text = File.read(Rails.root.join('lib', 'seeds', 'accr_data.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
  csv.each do |row|
    t = County.new
    t.name = row['name']
    t.num_cur_cases = row['num_cur_cases']
    t.num_cur_cases_b = row['num_cur_cases_b']
    t.num_cur_cases_w = row['num_cur_cases_w']
    t.num_cur_cases_o = row['num_cur_cases_o']
    t.population = row['population']
    t.num_dr = row['num_dr']
    t.num_dr_b = row['num_dr_b']
    t.num_dr_w = row['num_dr_w']
    t.num_dr_o = row['num_dr_o']
    t.save!
  end
  #when the database is seeded, copy the seed file to the app/assets/data/
  FileUtils.copy_file(FileUtils.pwd + "/lib/seeds/accr_data.csv", FileUtils.pwd + "/app/assets/data/map_data.csv")
  

elsif Rails.env.production?

  # We're in a production application! Stay secure! No accounts with password!


# # delete one of the ends if a problem 
# end

  # webinar1 = Webinar.create!(webinar_name: 'HIGHLY AGGRAVATED CASES', description: 'This webinar discusses Highly Aggravated Cases and has 3 guest speakers.', date_and_time:'2022-10-26 15:00:00 EST', speaker: 'Tamara Brady, Russell Stetler, Henderson Hill')
  # webinar2 = Webinar.create!(webinar_name: 'Other Defense Stuff', description: 'This is a placeholder webinar. This webinar has a relatively long description. A couple of long sentences describing the prerequisites of the webinar and the benefits of attending this webinar',  date_and_time:'2022-10-31 20:00:00 EST', speaker: 'Guest Speaker')

  webinar1.registrants.create(first_name: "Steve", last_name: "Erkel", email: "turtle@hotmail.com", county: "Warchester County", job: "PLumber", listserv: false )

end

