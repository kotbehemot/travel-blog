class Place < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  has_many :posts

  validates :name, :slug, :presence => true

  translates :name, :description, :fallbacks_for_empty_translations => true

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
