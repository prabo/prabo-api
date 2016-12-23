module V1
  class UserDetailsSerializer < ActiveModel::Serializer

    attributes :id, :username, :created_missions
    has_many :completed_missions, serializer: MissionSerializer
    has_many :created_missions, serializer: MissionSerializer

  end
end
