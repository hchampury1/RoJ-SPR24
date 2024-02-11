class WebinarsSpeakers < ActiveRecord::Migration[6.0]
  def change
    create_table :webinars_speakers do |t|
      t.integer :webinar_id
      t.integer :speaker_id
    end
  end
end
