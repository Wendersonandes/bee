class CreatePedComments < ActiveRecord::Migration
  def change
    create_table :ped_comments do |t|
      t.references :user, index: true
      t.references :pedido, index: true
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :ped_comments, :users
    add_foreign_key :ped_comments, :pedidos
  end
end
