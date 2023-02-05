class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.text :name
      t.integer :num_cur_cases
      t.integer :num_cur_cases_b
      t.integer :num_cur_cases_w
      t.integer :num_cur_cases_o
      t.integer :population
      t.integer :num_dr
      t.integer :num_dr_b
      t.integer :num_dr_w
      t.integer :num_dr_o

      t.timestamps
    end
  end
end
