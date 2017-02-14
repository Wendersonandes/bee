class AddCarrinhoIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :carrinho_id, :integer
  end
end
