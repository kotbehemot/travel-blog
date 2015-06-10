class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale, :set_main_photo

  protected
  def set_main_photo
    @main_photo = HomepagePhoto.order('created_at DESC').limit(1).first
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    ret_options = options
    if I18n.locale != I18n.default_locale
      ret_options = { locale: I18n.locale }.merge(options)
    else
      ret_options = { locale: nil }.merge(options)
    end
    ret_options
  end
end
