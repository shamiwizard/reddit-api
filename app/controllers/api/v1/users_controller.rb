class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
      message: 'Member',
      data: { user: current_user },
      is_success: true
    }, status: :ok
  end

  def update
    if current_user.update(update_params)
      render json: {
        message: 'Parameters are updated',
        data: { user: current_user },
        is_success: true
      }, status: :ok
    else
      render json: {
        message: 'Something goes wrong',
        data: nil,
        is_success: false
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.destroy
      render json: {
        message: 'Member is destroyed',
        data: nil,
        is_success: true
      }, status: :ok
    else
      render json: {
        message: 'Something goes wrong',
        data: nil,
        is_success: false
      }, status: :unprocessable_entity
    end
  end

  def update_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :username,
      :last_name,
      :first_name,
      :photo
    )
  end
end
