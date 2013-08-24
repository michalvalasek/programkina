class ApplicationController < ActionController::Base
  
  include UrlHelper
  
  protect_from_forgery

  def is_embed?
    !params[:context].nil? and params[:context] == 'embed'
  end

  def default_url_options
    is_embed? ? {:context => 'embed'} : {:context => nil}
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_url, :alert => exception.message
  end
end
