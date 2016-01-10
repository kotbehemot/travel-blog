class Admin::PostsController < Admin::BaseController
  respond_to :html, :json

  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.order('published_at DESC').page(params[:page])
    respond_with(@posts)
  end

  def show
    set_places
    respond_with(@post)
  end

  def new
    render '/admin/shared/invalid_locale' and return if I18n.locale != I18n.default_locale
    @post = Post.new
    set_places
    respond_with(@post)
  end

  def create
    @post = Post.new(permitted_params)
    @post.save
    respond_with(@post, :action => :show, :location => admin_posts_path)
  end

  def update
    @post.update(permitted_params)
    respond_with(@post, :action => :show, :location => admin_posts_path)
  end

  def destroy
    @post.destroy
    respond_with(@post, :action => :show, :location => admin_posts_path)
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def set_places
      @places = Place.order(:name).includes(:translations).with_locales(I18n.available_locales)
    end

    def permitted_params
      params.require(:post).permit(:title, :content, :summary, :published, :published_at, :created_at, :published_by, :place_id, :header_image, :footer_image, :video_link, :inverted_title, :photostory, :s_letter, :tag_list => [])
    end
end
