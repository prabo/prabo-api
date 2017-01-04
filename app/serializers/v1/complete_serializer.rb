module V1
  class CompleteSerializer < ActiveModel::Serializer

    attributes :id, :created_at
    has_one :user, serializer: UserSerializer
    has_one :mission, serializer: MissionSerializer
  end
end
