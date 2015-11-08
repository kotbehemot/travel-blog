class AddDataToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :title, :string
    add_column :locations, :description, :string, :limit => 2048
    add_column :locations, :distance, :string
    add_column :locations, :vehicle_type, :integer, :null => false, :default => 0
    add_attachment :locations, :image
  end
end
