class AddDensidadeToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :densidade, :float
  end
end
