class Location < ActiveRecord::Base
  validates :lat, :lon, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Date.today - 20.hours]) }
end
