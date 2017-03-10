class AddQuantidadeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :quantidade, :integer
  end
end
