class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.boolean :response_sent
      t.text :response_message
      t.date :date_sent

      t.timestamps
    end
  end
end
