module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST
    # Create an user
    def create
      @user = User.new user_params

      if @user.save!
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    # GET
    # Show an user
    def show
      @user = User.find(params[:id])
      render json: @user, serializer: V1::UserSerializer, root: nil
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
