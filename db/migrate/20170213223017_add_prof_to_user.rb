class AddProfToUser < ActiveRecord::Migration
  def change
    add_column :users, :prof, :string
  end
end
