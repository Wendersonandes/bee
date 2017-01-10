class AddSeguidoresToUsers < ActiveRecord::Migration
  def change
    add_column :users, :seguidores, :integer, :default => 0
  end
end
