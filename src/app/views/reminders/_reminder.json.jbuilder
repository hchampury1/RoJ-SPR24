json.extract! reminder, :id, :mail_entry_id, :user_email, :username, :notes, :reminder_time, :priority, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
