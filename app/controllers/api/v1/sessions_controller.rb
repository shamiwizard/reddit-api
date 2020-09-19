class Api::V1::SessionsController < Devise::SessionsController
  before_action :load_member, only: :create

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in 'user', @user
      render json: {
        message: 'Signed In Successfully',
        is_success: true,
        data: { user: @user }
      }, status: :ok
    else
      render json: {
        message: 'Signed In Failed - Unauthorized',
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit :username, :password
  end

  def load_member
    @user = User.find_for_database_authentication(username: sign_in_params[:username])

    if @user
      @user
    else
      render json: {
        message: 'Cannot get User',
        is_success: false,
        data: {}
      }, status: :not_found
    end
  end
end