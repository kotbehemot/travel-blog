class AddFotostoryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :photostory, :boolean, :null => false, :default => false
  end
end
