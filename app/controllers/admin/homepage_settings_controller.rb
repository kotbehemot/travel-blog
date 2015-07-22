class Admin::HomepageSettingsController < Admin::BaseController

  respond_to :html, :json
  before_action :set_setting, only: [:show, :update, :destroy]

  def index
    @settings = HomepageSetting.order(:key)
    respond_with(@settings)
  end

  def show
    respond_with(@setting)
  end

  def new
    @setting = HomepageSetting.new
    respond_with(@setting)
  end

  def create
    @setting = HomepageSetting.new(permitted_params)
    @setting.save
    respond_with(@setting, :action => :show, :location => admin_homepage_settings_path)
  end

  def update
    @setting.update(permitted_params)
    respond_with(@setting, :action => :show, :location => admin_homepage_settings_path)
  end

  def destroy
    @setting.destroy
    respond_with(@setting, :action => :show, :location => admin_homepage_settings_path)
  end

  private
  def set_setting
    @setting = HomepageSetting.find(params[:id])
  end

  def permitted_params
    params.require(:homepage_setting).permit(:key, :setting_value)
  end
end