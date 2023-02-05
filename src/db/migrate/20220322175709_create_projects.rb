class CreateProjects < ActiveRecord::Migration[6.0]
  def up
    create_table :projects do |t|
      t.text :name

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end

  def down
    drop_table :projects
  end
end
