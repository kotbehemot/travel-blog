class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :path => (Rails.env.production? ? "/ckeditor_assets/pictures/:id_partition/:style/:filename" : ":rails_root/public/system/ckeditor_assets/pictures/:id_partition/:style/:filename"),
                    :styles => { :content => '1600x1600>', :thumb => '118x100#', :original => '1600x1600>' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
