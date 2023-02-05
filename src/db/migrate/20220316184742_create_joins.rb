class CreateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :joins do |t|
      t.integer :mail_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
