class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.belongs_to :printer, index: true

      t.timestamps null: false
    end
    add_foreign_key :materials, :printers
  end
end
