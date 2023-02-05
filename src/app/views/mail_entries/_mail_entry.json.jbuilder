json.extract! mail_entry, :id, :label, :date, :sender_name, :inmate_id, :relevant_staff, :case_status, :current_age, :crime_age, :victim_race, :offender_race, :created_at, :updated_at
json.url mail_entry_url(mail_entry, format: :json)
