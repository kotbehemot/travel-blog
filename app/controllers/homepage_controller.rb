class HomepageController < ApplicationController

  def show
    @homepage_photos = HomepagePhoto.order('created_at DESC').map {|photo| photo.image.url}
    @places = Place.includes(:translations).order('place_translations.name').joins(:posts).distinct
    @latest_post = Post.where(:published => true).order('created_at DESC').limit(1).first
  end

  def map_locations
    @locations = Location.safe.order('emailed_at DESC').map {|l| {:lat => l.lat, :lon => l.lon, :date => l.emailed_at.to_s(:short)} }
    render :json => @locations
  end

end
