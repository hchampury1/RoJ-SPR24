class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.string :guid
      t.string :lawyername
      t.string :caseaddress
      t.string :lawfirm
      t.string :name
      t.date :date
      t.float :hours
      # t.decimal :fees
      t.text :description
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.belongs_to(:entered_by, foreign_key: { to_table: :users }, null: true)

      t.timestamps
    end
  end
end
