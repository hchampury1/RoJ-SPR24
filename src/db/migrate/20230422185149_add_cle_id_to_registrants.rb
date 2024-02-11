class AddCleIdToRegistrants < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :cleID, :string
  end
end
