class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :place

  has_attached_file :header_image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600' }
  has_attached_file :footer_image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600' }

  after_header_image_post_process :save_header_image_dimensions
  after_footer_image_post_process :save_footer_image_dimensions

  validates_attachment_presence :header_image
  validates_attachment_content_type :header_image, :footer_image, :content_type => /\Aimage/

  validates :title, :slug, :presence => true

  scope :published, -> { where(:published => true).order('published_at DESC') }

  is_impressionable

  before_save :set_published


  def header_image_defined?
    header_image.file? && header_image_width && header_image_height
  end

  def footer_image_defined?
    header_image.file? && footer_image_width && footer_image_height
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def parsed_content
    img_regexp = /<img[^>]*src="([^"]+)[^>]*style="[^"]*width:[ ]{0,1}([0-9]+)px;[^"]*height:[ ]{0,1}([0-9]+)px;[^"]*"[^>]*>/m
    new_content = content.gsub(img_regexp, '<div class=\'fullscreen background parallax\' style=\'width:100%; background-image:url(\1);\' data-img-width=\2 data-img-height=\3 data-diff=200></div>')
    new_content.html_safe
  end

  protected
  def save_header_image_dimensions
    geo = Paperclip::Geometry.from_file(header_image.queued_for_write[:original])
    self.header_image_width = geo.width
    self.header_image_height = geo.height
  end

  def save_footer_image_dimensions
    geo = Paperclip::Geometry.from_file(footer_image.queued_for_write[:original])
    self.footer_image_width = geo.width
    self.footer_image_height = geo.height
  end

  def set_published
    self.published_at = Date.today if published && published_at.nil?
  end
end
