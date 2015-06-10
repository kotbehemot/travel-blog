class HomepagePhoto < ActiveRecord::Base
  has_attached_file :image,
    :styles => { :thumb => '118x100#', :medium => '400x300#', :original => '1600' }

  after_image_post_process :save_image_dimensions

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /\Aimage/

  protected
  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(image.queued_for_write[:original])
    self.image_width = geo.width
    self.image_height = geo.height
  end
end
