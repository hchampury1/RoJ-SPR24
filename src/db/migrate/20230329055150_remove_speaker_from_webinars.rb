class RemoveSpeakerFromWebinars < ActiveRecord::Migration[6.0]
  def change
    remove_column :webinars, :speaker, :text
  end
end
