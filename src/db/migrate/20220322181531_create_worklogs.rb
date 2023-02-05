class CreateWorklogs < ActiveRecord::Migration[6.0]
  def up
    create_table :worklogs do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.text :desc_summary
      t.text :desc_body, default: '' 
      t.float :hours
      t.decimal :fee
      t.date :date
      t.belongs_to(:entered_by, foreign_key: { to_table: :users }, null: true)

      t.timestamps
    end
  end

  def down
    drop_table :worklogs
  end
end
