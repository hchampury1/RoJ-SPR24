class AddStateToRegistrants < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :state, :string
  end
end
