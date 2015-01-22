class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  
  before_action :set_locale
  before_action :set_layout
  before_action :set_profile

  def after_sign_in_path_for(resource)
    '/events'
  end

  def complete_profile
    if current_user && !current_user.profile.complete?
      redirect_to edit_profile_path(current_user.profile), :notice => 'Please complete your profile.'
    end
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def set_layout
    devise_controller? ? 'devise' : 'application'    
  end

  def set_profile
    if current_user and !current_user.profile
      redirect_to edit_profile_path
    end
  end

end
