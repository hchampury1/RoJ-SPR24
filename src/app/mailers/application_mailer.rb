#  Project name: ACCR Mail Manager
#  Description: Mail database and management system for ACCR community partner
#  Filename: reminders.scss
#  Description: Stylesheet for styles used by the 'Reminders' pages
#  Last modified on: 4/26/22
#  Code written by Team 24

# frozen_string_literal: true

# Controls emails sent out from the application
# TCNJ: you likely won't need this
class ApplicationMailer < ActionMailer::Base
  default from: 'accrmailer@gmail.com'
  layout 'mailer'
end
