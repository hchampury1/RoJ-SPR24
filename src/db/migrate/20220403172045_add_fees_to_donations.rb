class AddFeesToDonations < ActiveRecord::Migration[6.0]
  def change
    add_column :donations, :fees, :float
  end
end
