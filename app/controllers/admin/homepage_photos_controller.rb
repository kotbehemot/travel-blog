class Admin::HomepagePhotosController < Admin::BaseController

  respond_to :html, :json
  before_action :set_photo, only: [:show, :update, :destroy]

  def index
    @photos = HomepagePhoto.order('created_at DESC')
    respond_with(@photos)
  end

  def show
    respond_with(@photo)
  end

  def new
    @photo = HomepagePhoto.new
    respond_with(@photo)
  end

  def create
    @photo = HomepagePhoto.new(permitted_params)
    @photo.save
    respond_with(@photo, :action => :show, :location => admin_homepage_photos_path)
  end

  def update
    @photo.update(permitted_params)
    respond_with(@photo, :action => :show, :location => admin_homepage_photos_path)
  end

  def destroy
    @photo.destroy
    respond_with(@photo, :action => :show, :location => admin_homepage_photos_path)
  end

  private
  def set_photo
    @photo = HomepagePhoto.find(params[:id])
  end

  def permitted_params
    params.require(:homepage_photo).permit(:image)
  end
end