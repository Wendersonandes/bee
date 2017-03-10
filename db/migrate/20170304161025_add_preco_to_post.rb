class AddPrecoToPost < ActiveRecord::Migration
  def change
    add_column :posts, :preco, :float, default: 0
  end
end
