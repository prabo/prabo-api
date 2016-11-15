module V1
  class SessionSerializer < ActiveModel::Serializer

    attributes :email, :token_type, :id, :access_token

    def token_type
      'Bearer'
    end

  end
end