class PostsController < ApplicationController

  AVAILABLE_POST_SPECIALS = ['letter', 'photostory', 'movie']

  def index
    @posts = Post.published.page(params[:page]).per(6)
    @description = t('posts.latest.description')

    get_only_specific_posts if params[:special]
    get_tagged_posts if params[:tag]
    limit_posts_location if params[:place]

    @title ||= I18n.t('posts.latest.title')
    if @posts.empty?
      redirect_to latest_posts_path
      return
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

  private
  def get_only_specific_posts
    case params[:special]
    when 'letter'
      @posts = @posts.where(:s_letter => true)
      @title = @description = I18n.t('posts.specials.letter')
    when 'photostory'
      @posts = @posts.where(:photostory => true)
      @title = @description = I18n.t('posts.specials.photostory')
    when 'movie'
      @posts = @posts.where("posts.video_link IS NOT NULL AND posts.video_link <> ''")
      @title = @description = I18n.t('posts.specials.movie')
    end
  end

  def get_tagged_posts
    @posts = @posts.tagged_with(params[:tag])
    @description = I18n.t('posts.latest.tagged_with', :tag => params[:tag])
  end

  def limit_posts_location
    @place = (Place.friendly.find params[:place] rescue nil)
    unless @place.nil?
      @posts = @posts.where(:place_id => @place.id)
      @title = @place.name
      @description = @place.description
    else
      @posts = []
    end
  end

end
