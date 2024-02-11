class RenameOldTableToNewTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :inkindentry, :inkindentries
  end
end
