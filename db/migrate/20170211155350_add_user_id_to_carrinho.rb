class AddUserIdToCarrinho < ActiveRecord::Migration
  def change
    add_column :carrinhos, :user_id, :integer
  end
end
