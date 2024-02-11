class CreateDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :descriptions do |t|
      t.references :inkind, null: false, foreign_key: true
      t.string :description
      t.float :hours
      t.integer :value

      t.timestamps
    end
  end
end
