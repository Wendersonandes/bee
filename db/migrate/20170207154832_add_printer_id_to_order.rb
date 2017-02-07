class AddPrinterIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :printer_id, :integer
  end
end
