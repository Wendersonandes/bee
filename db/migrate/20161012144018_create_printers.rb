class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :name
      t.integer :marca_id
      t.integer :modelo_id

      t.timestamps null: false
    end
  end
end
