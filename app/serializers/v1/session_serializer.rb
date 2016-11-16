module V1
  class SessionSerializer < ActiveModel::Serializer

    attributes :id, :username, :token_type, :access_token

    def token_type
      'Bearer'
    end

  end
end