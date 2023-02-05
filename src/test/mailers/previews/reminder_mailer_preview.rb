# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview
    def new_reminder_email
        # Set up a temporary reminder for the preview
        reminder = Reminder.new(mail_entry_id: "12345", user_email: "nickleb474@gmail.com", username: "Nic", notes: "Reminder Notes", reminder_time: "2021-04-09", priority: "High")
    
        ReminderMailer.with(reminder: reminder).new_reminder_email
      end
end
