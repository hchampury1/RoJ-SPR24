class AddCallStatusToCalls < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :call_status, :string
  end
end
