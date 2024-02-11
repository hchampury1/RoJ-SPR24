class RemoveWebinarIdFromSpeakers < ActiveRecord::Migration[6.0]
  def change
    remove_column :speakers, :webinar_id
  end
end
