module V1
  class MissionsController < ApplicationController

    # GET
    # Show all missions
    def index
      @missions = Mission.all
      @missions.each { |e| e.set_target_user(authenticate_user!) }
      render json: @missions, each_serializer: V1::MissionSerializer, root: nil
    end

    # POST
    # Create an mission
    def create
      unless Category.exists?(:id => mission_params[:category_id])
        return render json: {error: 'カテゴリーが見つかりません。'}, status: 400
      end
      if Mission.exists?(:title => mission_params[:title])
        return render json: {error: 'そのミッション名は使われています。'}, status: 400
      end
      @mission = authenticate_user!.missions.build mission_params

      if @mission.save!
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: {error: 'ミッションを作成できませんでした。'}, status: :unprocessable_entity
      end
    end

    # DELETE
    # delete an mission
    def destroy
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.destroy!
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: {error: 'ミッションを削除できませんでした。'}, status: :unprocessable_entity
      end
    end

    # PUT
    # update an mission
    def update
      @mission = authenticate_user!.missions.find(params[:id])
      if !@mission.nil? and @mission.update mission_params
        render json: @mission, serializer: V1::MissionSerializer, root: nil
      else
        render json: {error: 'ミッションを更新できませんでした。'}, status: :unprocessable_entity
      end
    end

    # GET
    # Show an mission
    def show
      @mission = Mission.find(params[:id])
      @mission.set_target_user(authenticate_user!)
      render json: @mission, serializer: V1::MissionDetailsSerializer, root: nil
    end

    # PUT
    # complete an mission
    def complete
      @mission = Mission.find(params[:mission_id])
      unless authenticate_user!.complete(@mission)
        render json: {error: '既に達成済みです。'}, status: :unprocessable_entity
      else
        comp = authenticate_user!.completes.find_by_mission_id(@mission.id)
        render json: comp, serializer: V1::CompleteSerializer, root: nil
      end
    end

    # PUT
    # uncomplete an mission
    def uncomplete
      @mission = Mission.find(params[:mission_id])
      comp = authenticate_user!.completes.find_by_mission_id(@mission.id)
      unless authenticate_user!.uncomplete(@mission)
        render json: {error: '未達成のミッションです。'}, status: :unprocessable_entity
      else
        render json: comp, serializer: V1::CompleteSerializer, root: nil
      end
    end

    def render_404
      render json: {error: 'ミッションが見つかりません。'}, status: 404
    end

    private

    def mission_params
      @mission_params || params.permit(:title, :description, :category_id)
    end
  end
end
