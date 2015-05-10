class AddImagesDimensionsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :header_image_width, :integer
    add_column :posts, :header_image_height, :integer
    add_column :posts, :footer_image_width, :integer
    add_column :posts, :footer_image_height, :integer
  end
end
