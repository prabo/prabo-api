module V1
  class UserDetailsSerializer < ActiveModel::Serializer

    has_many :completed_missions, serializer: MissionSerializer
    has_many :created_missions, serializer: MissionSerializer

  end
end
