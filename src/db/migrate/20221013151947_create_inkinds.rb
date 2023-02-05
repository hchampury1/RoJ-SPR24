class CreateInkinds < ActiveRecord::Migration[6.0]
  def change
    create_table :inkinds do |t|
      t.string :name
      t.string :date
      t.integer :value
      t.string :description
      t.string :user
      t.string :genre
      t.string :donor_name, default: ""
      t.belongs_to :donor, index: true, foreign_key: true

      t.timestamps
    end
  end
end
