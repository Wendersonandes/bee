class AddPotenciaToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :potencia, :float
  end
end
