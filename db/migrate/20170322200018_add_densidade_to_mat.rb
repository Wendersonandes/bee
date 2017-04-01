class AddDensidadeToMat < ActiveRecord::Migration
  def change
    add_column :mats, :densidade, :float
  end
end
