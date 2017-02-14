class RemoveParamsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :status, :string
    remove_column :orders, :buyer_name, :string
    remove_column :orders, :reference, :string
    remove_column :orders, :street, :string
    remove_column :orders, :number, :string
    remove_column :orders, :complement, :string
    remove_column :orders, :district, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
    remove_column :orders, :postal_code, :string
  end
end
