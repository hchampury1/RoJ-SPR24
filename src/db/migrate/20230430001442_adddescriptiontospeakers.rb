class Adddescriptiontospeakers < ActiveRecord::Migration[6.0]
  def change
    add_column :speakers, :description, :string 
  end
end
