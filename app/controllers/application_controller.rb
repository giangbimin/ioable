class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  protected

  # configure permitted parameters for devise
  def configure_permitted_parameters
    added_attrs = [:email, :name, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end
end
