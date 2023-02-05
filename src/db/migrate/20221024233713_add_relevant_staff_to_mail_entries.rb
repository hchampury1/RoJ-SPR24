class AddRelevantStaffToMailEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :mail_entries, :relevant_staff, :string
  end
end
