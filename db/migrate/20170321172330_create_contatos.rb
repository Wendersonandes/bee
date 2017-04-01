class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :name
      t.string :email
      t.string :mensagem

      t.timestamps null: false
    end
  end
end
