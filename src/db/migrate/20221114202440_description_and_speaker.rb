class DescriptionAndSpeaker < ActiveRecord::Migration[6.0]
  def change

    add_column :webinars, :speaker, :text  
    rename_column :webinars, :description, :text

  end
end
