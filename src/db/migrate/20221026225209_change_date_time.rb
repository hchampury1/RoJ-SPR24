class ChangeDateTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :webinars, :time
    remove_column :webinars, :date
    add_column :webinars, :date_and_time, :datetime

  end
end
