class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.monetize :price, amount: { null: false, default: 0 }

    

   
    end
  end
end

