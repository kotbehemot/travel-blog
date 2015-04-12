class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates :title, :slug, :presence => true

  is_impressionable

  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
