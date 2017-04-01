class AddPagdadosToUser < ActiveRecord::Migration
  def change
    add_column :users, :cpf, :string
    add_column :users, :phone_code, :string
    add_column :users, :phone_number, :string
    add_column :users, :birthday, :string
    add_column :users, :street, :string
    add_column :users, :number, :string
    add_column :users, :complement, :string
    add_column :users, :district, :string
    add_column :users, :city_pag, :string
    add_column :users, :state, :string
    add_column :users, :postal_code, :string
  end
end
