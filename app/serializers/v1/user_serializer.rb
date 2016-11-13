module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :id, :email, :created_missions
    has_many :completed_missions

  end
end
