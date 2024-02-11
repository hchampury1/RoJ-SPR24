class ChangeColumn2 < ActiveRecord::Migration[6.0]
  def change
    change_column :registrants, :deregistered, :string, :defualt => "No"
  end
end
