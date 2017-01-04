module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # GET
    # Index users
    def index
      @users = User.all
      render json: @users, each_serializer: V1::UserSerializer, root: nil
    end

    # POST
    # Create an user
    def create
      if User.exists?(username: user_params[:username])
        return render json: {error: 'そのユーザ名は使われています。'}, status: :unprocessable_entity
      end
      @user = User.new user_params

      unless @user.save!
        return render json: {error: 'ユーザを作成することが出来ませんでした。'}, status: :unprocessable_entity
      end

      render json: @user, serializer: V1::SessionSerializer, root: nil
    end

    # GET
    # Show an user
    def show
      @user = User.find(params[:id])
      @user.created_missions.each { |e| e.set_target_user(authenticate_user!) }
      @user.completed_missions.each { |e| e.set_target_user(authenticate_user!) }
      render json: @user, serializer: V1::UserDetailsSerializer, root: nil
    end

    def render_404
      render json: {error: 'ユーザが見つかりません。'}, status: 404
    end

    private

    def user_params
      params.permit(:username, :password)
    end
  end
end
