class CreateHomepagePhotos < ActiveRecord::Migration
  def change
    create_table :homepage_photos do |t|
      t.string :name
      t.attachment :image
      t.integer :image_width
      t.integer :image_height
      t.timestamps null: false
    end
  end
end
