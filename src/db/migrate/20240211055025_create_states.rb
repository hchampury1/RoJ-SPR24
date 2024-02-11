class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false

      t.timestamps
    end
    # Optional: You can also add here some default states to start with.
  end
end
