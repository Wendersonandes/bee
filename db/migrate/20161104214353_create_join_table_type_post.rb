class CreateJoinTableTypePost < ActiveRecord::Migration
  def change
    create_join_table :types, :posts do |t|
      # t.index [:type_id, :post_id]
      # t.index [:post_id, :type_id]
    end
  end
end
