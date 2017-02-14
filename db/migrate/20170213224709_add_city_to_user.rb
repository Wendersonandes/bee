class AddCityToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :niver, :string
  end
end
