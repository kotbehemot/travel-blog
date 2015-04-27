class CreateHomepageSettings < ActiveRecord::Migration
  def change
    create_table :homepage_settings do |t|
      t.string :key, null: false
      t.string :setting_value
      t.timestamps null: false
    end
  end
end
