class AddModeloToPrinters < ActiveRecord::Migration
  def change
    add_column :printers, :modelo, :string
  end
end
