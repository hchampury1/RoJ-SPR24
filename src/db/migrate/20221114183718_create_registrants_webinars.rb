class CreateRegistrantsWebinars < ActiveRecord::Migration[6.0]
  def change
    create_table :registrants_webinars do |t|
      t.references :registrant, null: false, foreign_key: true
      t.references :webinar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
