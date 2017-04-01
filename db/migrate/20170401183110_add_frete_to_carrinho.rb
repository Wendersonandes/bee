class AddFreteToCarrinho < ActiveRecord::Migration
  def change
    add_column :carrinhos, :frete, :float
  end
end
