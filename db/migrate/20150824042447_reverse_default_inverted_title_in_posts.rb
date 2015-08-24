class ReverseDefaultInvertedTitleInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :inverted_title, :boolean, :null => false, :default => false
  end
end
