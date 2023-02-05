class CreateMailEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_entries do |t|
      t.text :label
      t.date :date
      t.text :sender_name
      t.integer :inmate_id
      t.integer :case_status
      t.integer :current_age
      t.integer :crime_age
      t.text :victim_race
      t.text :offender_race
      t.text :inquiryType
      t.text :pdf
      t.timestamps
    end
  end
end
