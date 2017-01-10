class AddMarcaToPrinters < ActiveRecord::Migration
  def change
    add_column :printers, :marca, :string
  end
end
