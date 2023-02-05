class AddHomeInstitutionToMailEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :mail_entries, :home_institution, :string
  end
end
