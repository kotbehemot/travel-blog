class PostsController < ApplicationController

  def index
    @posts = Post.where(:published => true).limit(20)
    @posts = @posts.tagged_with(params[:tag]) if params[:tag]
    if params[:place]
      @place = Place.friendly.find params[:place]
      @posts = @posts.where(:place_id => @place_id) unless @place.nil?
    end
  end

  def show
    @post = Post.friendly.find params[:id]
    impressionist(@post)
  end

end
