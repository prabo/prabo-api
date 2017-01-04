module V1
  class MissionDetailsSerializer < MissionSerializer
    has_many :completed_users, serializer: UserSerializer
  end
end
