class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :registrants, :cleID, :string, :default  => "None"
  end
end
