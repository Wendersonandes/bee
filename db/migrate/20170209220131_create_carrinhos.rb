class CreateCarrinhos < ActiveRecord::Migration
  def change
    create_table :carrinhos do |t|

      t.timestamps null: false
    end
  end
end
