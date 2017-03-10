class AddContaToUser < ActiveRecord::Migration
  def change
    add_column :users, :conta_pais, :string
    add_column :users, :conta_nome, :string
    add_column :users, :conta_sobrenome, :string
    add_column :users, :conta_cpf, :string
    add_column :users, :conta_banco, :string
    add_column :users, :conta_agencia, :string
    add_column :users, :conta_tipo, :string
    add_column :users, :conta_num, :string
  end
end
