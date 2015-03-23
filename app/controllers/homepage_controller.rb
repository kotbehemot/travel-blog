class HomepageController < ApplicationController

  def show
    @posts = Post.where(:published => true).order('counter_cache DESC').limit(5)
  end

end
