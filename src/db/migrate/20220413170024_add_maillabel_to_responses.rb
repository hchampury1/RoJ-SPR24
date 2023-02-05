class AddMaillabelToResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :responses, :maillabel, :string
  end
end
