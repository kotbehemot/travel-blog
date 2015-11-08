class Location < ActiveRecord::Base

  VEHICLE_TYPES = {
    :bike => 0,
    :car => 1,
    :boat => 2,
    :plane => 3,
    :train => 4
  }

  validates :lat, :lon, :emailed_at, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Time.now - 20.hours]) }

  has_attached_file :image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600' }

  def to_s
    "#{lat.round(3)}, #{lon.round(3)} (#{emailed_at.to_s(:short)})"
  end
end
