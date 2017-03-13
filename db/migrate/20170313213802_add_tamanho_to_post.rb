class AddTamanhoToPost < ActiveRecord::Migration
  def change
    add_column :posts, :x, :float
    add_column :posts, :y, :float
    add_column :posts, :z, :float
  end
end
