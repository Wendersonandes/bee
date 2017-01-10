class AddActiveToPrinters < ActiveRecord::Migration
  def change
    add_column :printers, :active, :string
  end
end
