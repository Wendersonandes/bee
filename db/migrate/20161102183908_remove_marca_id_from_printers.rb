class RemoveMarcaIdFromPrinters < ActiveRecord::Migration
  def change
    remove_column :printers, :marca_id, :integer
  end
end
