class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for  User
  # before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in) do |user_params|
  #     user_params.permit(:username)
  #   end
  # end
end
