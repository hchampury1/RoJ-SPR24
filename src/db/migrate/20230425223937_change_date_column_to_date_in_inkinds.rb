class ChangeDateColumnToDateInInkinds < ActiveRecord::Migration[6.0]
  def up
    change_column :inkinds, :date, 'date USING CAST(date AS date)'
  end

  def down
    change_column :inkinds, :date, :string
  end
end
