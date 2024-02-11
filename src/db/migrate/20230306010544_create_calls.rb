class CreateCalls < ActiveRecord::Migration[6.0]
  def change
    create_table :calls do |t|
      t.string :caller_type
      t.string :name
      t.string :phone_number
      t.string :inmate_num
      t.string :institution
      t.string :location
      t.string :point_of_contact
      t.date :date
      t.string :notes

      t.timestamps
    end
  end
end
