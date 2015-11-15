class PostsController < ApplicationController

  def index
    @posts = Post.published.page(params[:page]).per(6)
    @description = t('posts.latest.description')
    if params[:tag]
      @posts = @posts.tagged_with(params[:tag])
      @description = I18n.t('posts.latest.tagged_with', :tag => params[:tag])
    end
    if params[:place]
      @place = (Place.friendly.find params[:place] rescue nil)
      unless @place.nil?
        @posts = @posts.where(:place_id => @place.id)
        @title = @place.name
        @description = @place.description
      else
        @posts = []
      end
    end
    @title ||= I18n.t('posts.latest.title')
    if @posts.empty?
      @posts = Post.published.page(params[:page]).per(6)
      @description = I18n.t('posts.latest.bad_tag', :tag => params[:place] || params[:tag])
    end
    @places = Place.all
    @post_photos = @posts.map {|p| p.header_image.url }
  end

  def show
    @post = Post.friendly.find params[:id]
    impressionist(@post, nil, :unique => [:session_hash])

    @title = @post.title
    @description = @post.summary
    @keywords = @post.place.description if @post.place_id && !@post.place.description.blank?
    @meta_image_url = @post.header_image.url

    @next_post = Post.where(:published => true).where(['published_at > ?', @post.published_at]).order('published_at ASC').limit(1).first
    @previous_post = Post.where(:published => true).where(['published_at < ?', @post.published_at]).order('published_at DESC').limit(1).first
    @post_presenter = PostContentPresenter.new(@post)
  end

end
