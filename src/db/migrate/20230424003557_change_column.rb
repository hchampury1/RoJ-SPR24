class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :registrants, :deregistered, :string, :defualt => "No"
    change_column :registrants, :cleID, :string, :default  => "None"
  end
end
