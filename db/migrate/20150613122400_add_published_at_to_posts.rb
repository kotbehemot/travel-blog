class AddPublishedAtToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :publication_date
    add_column :posts, :published_at, :date
    add_index :posts, :published_at

    Post.update_all('published_at = created_at')
  end
end
