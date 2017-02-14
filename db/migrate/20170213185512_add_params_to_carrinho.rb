class AddParamsToCarrinho < ActiveRecord::Migration
  def change
    add_column :carrinhos, :buyer_name, :string
    add_column :carrinhos, :email, :string
    add_column :carrinhos, :cpf, :string
    add_column :carrinhos, :reference, :string
    add_column :carrinhos, :status, :string
    add_column :carrinhos, :price, :float
    add_column :carrinhos, :street, :string
    add_column :carrinhos, :number, :string
    add_column :carrinhos, :complement, :string
    add_column :carrinhos, :district, :string
    add_column :carrinhos, :city, :string
    add_column :carrinhos, :state, :string
    add_column :carrinhos, :postal_code, :string
  end
end
