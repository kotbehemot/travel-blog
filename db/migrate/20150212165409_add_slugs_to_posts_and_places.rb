class AddSlugsToPostsAndPlaces < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, null: false
    add_column :places, :slug, :string, null: false
    add_index :posts, :slug, unique: true
    add_index :places, :slug, unique: true
  end
end
