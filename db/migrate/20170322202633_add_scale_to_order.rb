class AddScaleToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :scale, :float
  end
end
