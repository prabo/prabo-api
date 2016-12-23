module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :id, :username, :created_missions
    has_many :completed_missions, serializer: MissionMinSerializer
    has_many :created_missions, serializer: MissionMinSerializer

  end
end
