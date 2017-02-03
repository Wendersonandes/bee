class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :price
      t.string :status
      t.string :buyer_name
      t.string :reference

      t.timestamps null: false
    end
  end
end
