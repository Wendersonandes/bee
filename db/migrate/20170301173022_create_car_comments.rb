class CreateCarComments < ActiveRecord::Migration
  def change
    create_table :car_comments do |t|
      t.references :user, index: true
      t.references :carrinho, index: true
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :car_comments, :users
    add_foreign_key :car_comments, :carrinhos
  end
end
