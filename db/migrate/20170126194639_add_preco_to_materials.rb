class AddPrecoToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :preco, :float
  end
end
