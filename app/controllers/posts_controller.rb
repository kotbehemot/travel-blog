class PostsController < ApplicationController

  def index
    @posts = Post.where(:published => true).limit(20)
    if params[:tag]
      @posts = @posts.tagged_with(params[:tag])
      @description = I18n.t('posts.latest.tagged_with', :tag => params[:tag])
    end
    if params[:place]
      @place = (Place.friendly.find params[:place] rescue nil)
      unless @place.nil?
        @posts = @posts.where(:place_id => @place_id)
        @title = @place.name
        @description = @place.description
      else
        @posts = []
      end
    end
    @title ||= I18n.t('posts.latest.title')
    if @posts.empty?
      @posts = Post.where(:published => true).limit(20)
      @description = I18n.t('posts.latest.bad_tag', :tag => params[:place] || params[:tag])
    end
  end

  def show
    @post = Post.friendly.find params[:id]
    impressionist(@post, nil, :unique => [:session_hash])
  end

end
