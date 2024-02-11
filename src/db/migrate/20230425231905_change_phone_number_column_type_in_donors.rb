class ChangePhoneNumberColumnTypeInDonors < ActiveRecord::Migration[6.0]
  def up
    change_column :donors, :phoneNumber, :string
  end

  def down
    change_column :donors, :phoneNumber, :bigint
  end
end
