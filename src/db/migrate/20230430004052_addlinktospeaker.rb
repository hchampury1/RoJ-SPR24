class Addlinktospeaker < ActiveRecord::Migration[6.0]
  def change
    add_column :speakers, :link, :string 
  end
end
