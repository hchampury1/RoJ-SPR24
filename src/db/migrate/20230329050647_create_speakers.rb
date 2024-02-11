class CreateSpeakers < ActiveRecord::Migration[6.0]
  def change
    create_table :speakers do |t|
      t.string :name
      t.integer :webinar_id

      t.timestamps
    end
    add_index :speakers, :webinar_id
  end
end
