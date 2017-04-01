class AddDesgasteToModelo < ActiveRecord::Migration
  def change
    add_column :modelos, :desgaste, :float
  end
end
