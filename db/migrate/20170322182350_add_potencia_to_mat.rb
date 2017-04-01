class AddPotenciaToMat < ActiveRecord::Migration
  def change
    add_column :mats, :potencia, :float
  end
end
