class AddSLetterToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :s_letter, :boolean, :null => false, :default => false
  end
end
