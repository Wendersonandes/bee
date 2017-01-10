class CreateJoinTableColorMaterial < ActiveRecord::Migration
  def change
    create_join_table :colors, :materials do |t|
      # t.index [:color_id, :material_id]
      # t.index [:material_id, :color_id]
    end
  end
end
