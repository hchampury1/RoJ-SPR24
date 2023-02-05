class CreateEventDetails < ActiveRecord::Migration[6.0]
  def change
    # drop_table :event_details
    create_table :event_details do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.string :speakers
      t.text :description
      t.text :event_link
      t.string :created_by

      t.timestamps
    end
  end
end
