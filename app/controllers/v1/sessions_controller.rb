module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(username: params[:username])
      return invalid_login unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login
      end
    end

    private

    def invalid_login
      warden.custom_failure!
      render json: { error: '不正なログインです。' }
    end
  end

end
