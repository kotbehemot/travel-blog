class HomepageSetting < ActiveRecord::Base

  def self.by_slug(slug)
    self.where(:key => slug.to_s).first_or_create
  end

  def self.value(slug)
    by_slug(slug).setting_value
  end

  def self.update_value(slug, value)
    setting = self.where(:key => slug.to_s).first_or_initialize
    setting.setting_value = value.to_s
    setting.save
  end
end
