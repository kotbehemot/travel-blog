class Location < ActiveRecord::Base
  validates :lat, :lon, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Date.today - 30.hours]) }
end
