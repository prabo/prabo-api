module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :id, :username, :completed_missions_count, :created_missions_count

    def completed_missions_count
      object.completed_missions.count
    end

    def created_missions_count
      object.created_missions.count
    end

  end
end
