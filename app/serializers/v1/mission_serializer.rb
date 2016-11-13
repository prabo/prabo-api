module V1
  class MissionSerializer < ActiveModel::Serializer

    attributes :id, :title, :description, :author_id

    def author_id
      object.author.id
    end

  end
end
