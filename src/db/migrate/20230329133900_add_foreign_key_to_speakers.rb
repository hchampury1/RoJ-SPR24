class AddForeignKeyToSpeakers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :speakers, :webinars, column: :webinar_id, primary_key: :id
  end
end
