class CreateWebinars < ActiveRecord::Migration[6.0]
  def change
    create_table :webinars do |t|
      t.string :webinar_name
      t.string :description
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
