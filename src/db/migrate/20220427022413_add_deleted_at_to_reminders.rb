class AddDeletedAtToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :deleted_at, :datetime
    add_index :reminders, :deleted_at
  end
end
