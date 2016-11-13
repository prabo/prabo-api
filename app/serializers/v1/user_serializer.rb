module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :email, :token_type, :user_id

    def user_id
      object.id
    end

  end
end
