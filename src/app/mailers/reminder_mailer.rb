#  Project name: ACCR Mail Manager
#  Description: Mail database and management system for ACCR community partner
#  Filename: reminders.scss
#  Description: Stylesheet for styles used by the 'Reminders' pages
#  Last modified on: 4/26/22
#  Code written by Team 24

class ReminderMailer < ApplicationMailer
    def new_reminder_email
        @reminder = params[:reminder]

        mail(to: @reminder.user_email, subject: "ACCR Mail Reminder")
    end
end
