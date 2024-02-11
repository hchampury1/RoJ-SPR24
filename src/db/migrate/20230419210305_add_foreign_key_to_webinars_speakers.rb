class AddForeignKeyToWebinarsSpeakers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :webinars_speakers, :webinars, column: :webinar_id
    add_foreign_key :webinars_speakers, :speakers, column: :speaker_id
    change_column_null :webinars_speakers, :webinar_id, false
    change_column_null :webinars_speakers, :speaker_id, false
  end
end
