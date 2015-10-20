class Admin::PlacesController < Admin::BaseController

  respond_to :html, :json

  before_action :set_place, only: [:show, :update, :destroy]

  def index
    @places = Place.order('created_at DESC')
    respond_with(@places)
  end

  def show
    respond_with(@place)
  end

  def new
    render '/admin/shared/invalid_locale' and return if I18n.locale != I18n.default_locale
    @place = Place.new
    respond_with(@place)
  end

  def create
    @place = Place.new(permitted_params)
    @place.save
    respond_with(@place, :action => :show, :location => admin_places_path)
  end

  def update
    @place.update(permitted_params)
    respond_with(@place, :action => :show, :location => admin_places_path)
  end

  def destroy
    @place.destroy
    respond_with(@place, :action => :show, :location => admin_places_path)
  end

  private
  def set_place
    @place = Place.friendly.find(params[:id])
  end

  def permitted_params
    params.require(:place).permit(:name, :slug, :description)
  end
end
