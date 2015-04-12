class RenamePostsCounterCacheToImpressionsCount < ActiveRecord::Migration
  def change
    rename_column :posts, :counter_cache, :impressions_count
    change_column :posts, :impressions_count, :integer, :default => 0, :null => false
  end
end
