class Admin::LocationsController < Admin::BaseController

  respond_to :html, :json

  before_action :set_location, only: [:show, :update, :destroy]

  def index
    @locations = Location.order('emailed_at DESC').page(params[:page]).per(60)
    respond_with(@locations)
  end

  def show
    respond_with(@location)
  end

  def new
    @location = Location.new
    respond_with(@location)
  end

  def create
    @location = Location.new(permitted_params)
    @location.save
    respond_with(@location, :action => :show, :location => admin_locations_path)
  end

  def update
    @location.update(permitted_params)
    respond_with(@location, :action => :show, :location => admin_locations_path)
  end

  def destroy
    @location.destroy
    respond_with(@location, :action => :show, :location => admin_locations_path)
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def permitted_params
    params.require(:location).permit(:lat, :lon, :emailed_at)
  end
end
