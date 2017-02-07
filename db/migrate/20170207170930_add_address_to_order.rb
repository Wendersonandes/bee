class AddAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :street, :string
    add_column :orders, :number, :string
    add_column :orders, :complement, :string
    add_column :orders, :district, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :postal_code, :string
  end
end
