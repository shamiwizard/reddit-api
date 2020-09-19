class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User

  def render_json(message, data = {}, is_success = false, status = :bad_request)
    render json: {
      message: message,
      is_success: is_success,
      data: data
    }, status: status
  end
end
