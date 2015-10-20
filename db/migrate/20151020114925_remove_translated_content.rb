class RemoveTranslatedContent < ActiveRecord::Migration
  def change
    remove_column :places, :name, :string
    remove_column :places, :description, :text

    remove_column :posts, :title, :string
    remove_column :posts, :summary, :string, :limit => 2048
    remove_column :posts, :content, :text
  end
end
