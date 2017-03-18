class AddPrintsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :prints, :integer, default: 0
  end
end
