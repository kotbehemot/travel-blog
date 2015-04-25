class HomepageController < ApplicationController

  def show
    @posts = Post.where(:published => true).order('counter_cache DESC').limit(5)
    @locations = Location.all.map {|l| {:lat => l.lat, :lon => l.lon, :date => l.emailed_at.to_s(:short)} }
  end

end
