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

    # PUT
    # update an mission
    def update
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.update mission_params
        render json: @mission, root: nil
      else
        render json: { error: t('message.mission_update_error') }, status: :unprocessable_entity
      end
    end

    # GET
    # Show an mission
    def show
      @mission = Mission.find(params[:id])
      render json: @mission, root: nil
    end

    # PUT
    # complete an mission
    def complete
      @mission = authenticate_user!.missions.find(params[:mission_id])
      if @mission.nil?
        render json: { error: 'Not found or You are author.' }, status: :unprocessable_entity
      elsif !authenticate_user!.complete(@mission)
        render json: { error: 'Already completed.' }, status: :unprocessable_entity
      else
        render json: { :status => 'ok', :message => 'Success!' }, root: nil
      end
    end

    # PUT
    # uncomplete an mission
    def uncomplete
      @mission = authenticate_user!.missions.find(params[:mission_id])
      if @mission.nil?
        render json: { error: 'Not found or You are author.' }, status: :unprocessable_entity
      elsif !authenticate_user!.uncomplete(@mission)
        render json: { error: 'You are not completed this mission.' }, status: :unprocessable_entity
      else
        render json: { :status => 'ok', :message => 'Success!' }, root: nil
      end
    end
    private

    def mission_params
      params.permit(:title, :description)
    end
  end
end
