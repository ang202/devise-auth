class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include Pundit
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action."},status: :unauthorized
  end

  def not_authorized
    render json: { error: "Not authorized" }, status: :unauthorized
  end
end
