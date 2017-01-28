class AddVolumeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :volume, :float
  end
end
