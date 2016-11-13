module V1
  class MissionsController < ApplicationController

    # GET
    # Show all missions
    def index
      @missions = Mission.all
      render json: @missions, root: nil
    end

    # POST
    # Create an mission
    def create
      @mission = Mission.new mission_params

      if @mission.save!
        render json: @mission, root: nil
      else
        render json: { error: t('message.mission_create_error') }, status: :unprocessable_entity
      end
    end

    # GET
    # Show an mission
    def show
      @mission = Mission.find(params[:id])
      render json: @mission, root: nil
    end

    private

    def mission_params
      params.permit(:email, :password)
    end
  end
end
