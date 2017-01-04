module V1
  class CategorySerializer < ActiveModel::Serializer

    attributes :id, :name, :missions_count

    def missions_count
      object.missions.count
    end
  end
end
