class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.text :mail_entry_id
      t.text :user_email
      t.text :username
      t.text :notes
      t.date :reminder_time
      t.text :priority

      t.timestamps
    end
  end
end
