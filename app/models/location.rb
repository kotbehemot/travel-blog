class Location < ActiveRecord::Base
  validates :lat, :lon, :emailed_at, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Time.now - 20.hours]) }

  def to_s
    "#{lat.round(3)}, #{lon.round(3)} (#{emailed_at.to_s(:short)})"
  end
end
