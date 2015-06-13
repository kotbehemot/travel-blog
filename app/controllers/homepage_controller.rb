class HomepageController < ApplicationController

  def show
    #@posts = Post.where(:published => true).order('counter_cache DESC').limit(5)
    @homepage_photos = HomepagePhoto.order('created_at DESC').map {|photo| photo.image.url}
    @locations = Location.safe.order('emailed_at ASC').map {|l| {:lat => l.lat, :lon => l.lon, :date => l.emailed_at.to_s(:short)} }
    @latest_post = Post.published.first
  end

end
