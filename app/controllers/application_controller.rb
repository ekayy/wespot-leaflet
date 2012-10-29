class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # Devise sessions: redirect to specific page after sign in
  def after_sign_in_path_for(resource)
	 	admin_path
	end
end
