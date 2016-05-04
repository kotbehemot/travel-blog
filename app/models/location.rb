class Location < ActiveRecord::Base

  VEHICLE_TYPES = ['bike', 'car', 'boat', 'plane', 'train']

  validates :lat, :lon, :emailed_at, :presence => true

  scope :safe, -> { where(["emailed_at < ?", Time.now - 4.hours]) }

  has_attached_file :image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600' }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def to_s
    "#{lat.round(3)}, #{lon.round(3)} (#{emailed_at.to_s(:short)})"
  end

  def vehicle_name
    VEHICLE_TYPES.at(vehicle_type)
  end
end
