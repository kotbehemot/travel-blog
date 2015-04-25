class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lat
      t.decimal :lon
      t.datetime :emailed_at
      t.belongs_to :post
      t.timestamps null: false
    end
  end
end
