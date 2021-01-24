class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller? 

  protected

    def configure_permitted_parameters
      sign_in_params = [:name, :password]
      sign_up_params = [:name, :email, :password, :password_confirmation]
      update_params = [:email, :password, :password_confirmation, :current_password, :age, :language, :sex, :profile]

      devise_parameter_sanitizer.permit :sign_in, keys: sign_in_params
      devise_parameter_sanitizer.permit :sign_up, keys: sign_up_params
      devise_parameter_sanitizer.permit :account_update, keys: update_params
    end
end
