class CreateDonors < ActiveRecord::Migration[6.0]
  def change
    create_table :donors do |t|
      t.string :email
      t.integer :phoneNumber
      t.string :location
      t.string :donor_name
      t.timestamps
    end
  end
end
