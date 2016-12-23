module V1
  class CategoryDetailsSerializer < ActiveModel::Serializer

    attributes :id, :name
    has_many :missions, serializer: MissionSerializer

  end
end
