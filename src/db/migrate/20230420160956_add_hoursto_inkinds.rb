class AddHourstoInkinds < ActiveRecord::Migration[6.0]
  def change
    add_column :inkinds, :hours, :float
  end
end
