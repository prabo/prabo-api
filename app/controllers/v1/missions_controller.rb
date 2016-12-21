module V1
  class MissionsController < ApplicationController

    # GET
    # Show all missions
    def index
      @missions = Mission.all
      @missions.each { |e| e.set_target_user(authenticate_user!)}
      render json: @missions, each_serializer: V1::MissionSerializer, root: nil
    end

    # POST
    # Create an mission
    def create
      category = Category.find(mission_params[:category_id])
      unless category
        render json: { error: t('message.category_undefined_error') }, status: :unprocessable_entity
      end
      @mission = authenticate_user!.missions.build mission_params

      if @mission.save!
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: { error: t('message.mission_create_error') }, status: :unprocessable_entity
      end
    end

    # DELETE
    # delete an mission
    def destroy
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.destroy!
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: { error: t('message.mission_create_error') }, status: :unprocessable_entity
      end
    end

    # PUT
    # update an mission
    def update
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.update mission_params
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: { error: t('message.mission_update_error') }, status: :unprocessable_entity
      end
    end

    # GET
    # Show an mission
    def show
      @mission = Mission.find(params[:id])
      @mission.set_target_user(authenticate_user!)
      render json: @mission, serializer: V1::MissionSerializer, root: nil
    end

    # PUT
    # complete an mission
    def complete
      @mission = Mission.find(params[:mission_id])
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
      @mission = Mission.find(params[:mission_id])
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
      @mission_params || params.permit(:title, :description, :category_id)
    end
  end
end
