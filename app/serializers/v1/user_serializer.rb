module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :id, :email, :completed_missions

    def created_missions
      object.missions
    end

  end
end
