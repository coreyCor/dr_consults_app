class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :use_user_time_zone, if: :current_user

  protected

  # Devise: permit extra parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end



  # Admin authorization
  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
  private


def use_user_time_zone(&block)
  Time.use_zone(current_user.time_zone || "Pacific Time (US & Canada)", &block)
end
end
