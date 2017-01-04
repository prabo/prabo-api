module V1
  class MissionSerializer < ActiveModel::Serializer

    attributes :id, :title, :description, :is_completed, :completed_users_count
    has_one :category, serializer: CategorySerializer
    has_one :author, serializer: UserSerializer

    def is_completed
      object.target_completed?
    end

    def completed_users_count
      object.completed_users.count
    end
  end
end
