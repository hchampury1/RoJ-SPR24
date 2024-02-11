class ChangeColumnNameInDonors < ActiveRecord::Migration[6.0]
  def change
    change_column :donors, :phoneNumber, :bigint
  end
end
