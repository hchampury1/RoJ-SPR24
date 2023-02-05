class AddMailidToResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :responses, :mailid, :integer
  end
end
