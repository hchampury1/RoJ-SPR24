class TextToDescription < ActiveRecord::Migration[6.0]
  def change

    rename_column :webinars, :text, :description
    change_column :webinars, :description, :text
  end
end
