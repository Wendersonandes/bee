class RemoveProductIdFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :product_id, :integer
  end
end
