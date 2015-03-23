class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :summary, limit: 2048
      t.text :content
      t.belongs_to :place
      t.integer :counter_cache
      t.timestamps null: false
    end
  end
end
