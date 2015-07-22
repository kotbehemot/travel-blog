# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['odometer_bike', 'odometer_train', 'odometer_ship', 'odometer_rocket', 'odometer_plane'].each do |odo_key|
  homepage_odo = HomepageSetting.where(:key => odo_key).first_or_initialize
  homepage_odo.setting_value = 0
  homepage_odo.save
end