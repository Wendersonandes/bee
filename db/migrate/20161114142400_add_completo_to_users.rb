class AddCompletoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :completo, :string
  end
end
