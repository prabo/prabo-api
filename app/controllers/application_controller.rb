class ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user_from_token!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # 例外処理
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404


  respond_to :json

  ##
  # User Authentication
  # Authenticates the user with OAuth2 Resource Owner Password Credentials
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authenticate_error
    end
  end

  private

  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authenticate_error
    # User's token is either invalid or not in the right format
    render json: {error: t('messages.failure_authentications')}, status: 401 # Authentication
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :password, :password_confirmation) }
  end

  def render_400
    render json: {error: '不正なリクエストです。'}, status: 400
  end

  def render_404
    render json: {error: '見つかりません。'}, status: 404
  end

end
