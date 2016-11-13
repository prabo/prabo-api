module V1
  class MissionSerializer < ActiveModel::Serializer

    attributes :title, :description, :author_id

    def author_id
      binding.pry
      object.author.id
    end

  end
end
