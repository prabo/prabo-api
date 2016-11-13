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
      @mission = authenticate_user!.missions.build mission_params

      if @mission.save!
        render json: @mission, root: nil
      else
        render json: { error: t('message.mission_create_error') }, status: :unprocessable_entity
      end
    end

    # DELETE
    # delete an mission
    def destroy
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.destroy!
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
      params.permit(:title, :description)
    end
  end
end
