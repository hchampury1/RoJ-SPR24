class CreateJobTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :job_types do |t|
      t.string :name
      t.decimal :fee, precision: 8, scale: 2

      t.timestamps
    end
  end
end
