class AddTranslationTables < ActiveRecord::Migration
  def up
    Place.create_translation_table!({
      :name => :string,
      :description => :text
    }, {
      :migrate_data => true
    })
    Post.create_translation_table!({
      :title => :string,
      :summary => {:type => :string, :limit => 2048},
      :content => :text
    }, {
      :migrate_data => true
    })
  end

  def down
    Place.drop_translation_table! :migrate_data => true
    Post.drop_translation_table! :migrate_data => true
  end
end
