class AddCustosToPrinter < ActiveRecord::Migration
  def change
    add_column :printers, :kwh, :float
    add_column :printers, :desgaste, :float
  end
end
