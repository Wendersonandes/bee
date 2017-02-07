class AddUserIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :post_id, :integer
    add_column :orders, :material, :string
    add_column :orders, :color, :string
    add_column :orders, :resolution, :string
    add_column :orders, :preench, :string
  end
end
