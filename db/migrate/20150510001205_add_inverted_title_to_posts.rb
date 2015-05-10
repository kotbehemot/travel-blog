class AddInvertedTitleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :inverted_title, :boolean, :null => false, :default => true
  end
end
