class AddUserIdToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :user_id, :integer
  end
end
