class AddDeregisteredToRegistrants < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :deregistered, :string, _default: "No"
  end
end
