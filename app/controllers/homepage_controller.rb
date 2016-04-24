class HomepageController < ApplicationController

  def show
    @homepage_photos = HomepagePhoto.order('created_at DESC').map {|photo| photo.image.url}
    @places = Place.with_translations(I18n.locale).order(:name).joins(:posts).select('places.*, place_translations.name').distinct
    @latest_post = Post.where(:published => true).order('created_at DESC').limit(1).first
  end

  def map_locations
    @locations = Location.safe.order('emailed_at DESC').map {|l| {:lat => l.lat, :lon => l.lon, :date => l.emailed_at.to_s(:short), :vehicle_type => l.vehicle_type} }
    render :json => @locations
  end

end
