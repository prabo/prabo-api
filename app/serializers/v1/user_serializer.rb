module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :id, :username, :created_missions
    has_many :completed_missions

  end
end
