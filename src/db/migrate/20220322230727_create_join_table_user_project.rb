class CreateJoinTableUserProject < ActiveRecord::Migration[6.0]
  def up
    create_join_table(:users, :projects, column_options: { null: true }) do |t|
      t.index [:user_id, :project_id]
    end
  end

  def down
    drop_table :users_projects
  end
end
