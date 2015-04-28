class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_attachment :posts, :header_image
    add_attachment :posts, :footer_image
  end
end
