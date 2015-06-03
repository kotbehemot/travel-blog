class Location < ActiveRecord::Base
  validates :lat, :lon, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Time.now - 20.hours]) }
end
