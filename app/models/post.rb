class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_attached_file :header_image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600x1600>' }
  has_attached_file :footer_image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600x1600>' }

  validates_attachment_presence :header_image
  validates_attachment_content_type :header_image, :footer_image, :content_type => /\Aimage/

  validates :title, :slug, :presence => true

  is_impressionable

  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
