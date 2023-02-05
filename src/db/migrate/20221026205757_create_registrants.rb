class CreateRegistrants < ActiveRecord::Migration[6.0]
  def change
    create_table :registrants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :webinar
      t.string :county
      t.string :job
      t.boolean :listserv
      t.text :topics

      t.timestamps
    end
  end
end
