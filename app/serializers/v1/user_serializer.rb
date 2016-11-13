module V1
  class UserSerializer < ActiveModel::Serializer

    attributes :email, :token_type, :user_id

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end

  end
end
