class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    permitted_params = [:nom, :prenom, :pseudo, :email, :password, :password_confirmation]

     if params[:action] == 'update'
       devise_parameter_sanitizer.for(:account_update) {
         |u| u.permit(permitted_params << :current_password)
       }
     elsif params[:action] == 'create'
       devise_parameter_sanitizer.for(:sign_up) {
         |u| u.permit(permitted_params)
       }
     end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
