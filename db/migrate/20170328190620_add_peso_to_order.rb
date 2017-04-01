class AddPesoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :peso, :float
  end
end
