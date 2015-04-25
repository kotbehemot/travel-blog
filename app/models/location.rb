class Location < ActiveRecord::Base
  validates :lat, :lon, :presence => true
end
