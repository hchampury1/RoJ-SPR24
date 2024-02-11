class AddAmountAndPaidToTableName < ActiveRecord::Migration[6.0]
  def change
    add_column :registrants, :amount, :integer
    add_column :registrants, :paid, :boolean
  end
end
