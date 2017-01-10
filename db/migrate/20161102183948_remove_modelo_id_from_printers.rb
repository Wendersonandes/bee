class RemoveModeloIdFromPrinters < ActiveRecord::Migration
  def change
    remove_column :printers, :modelo_id, :integer
  end
end
