module V1
  class CategoryDetailsSerializer < CategorySerializer
    has_many :missions, serializer: MissionSerializer
  end
end
