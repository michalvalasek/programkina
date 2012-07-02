class ApplicationController < ActionController::Base
  
  include UrlHelper
  
  protect_from_forgery

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to dashboard_url, :alert => exception.message
  end
end
