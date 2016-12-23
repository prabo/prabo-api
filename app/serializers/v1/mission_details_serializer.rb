module V1
  class MissionDetailsSerializer < ActiveModel::Serializer

    attributes :id, :title, :description, :author_id, :is_completed
    has_one :category, serializer: CategorySerializer
    has_one :author, serializer: UserMinSerializer
    has_many :completed_users, serializer: UserMinSerializer

    def author_id
      object.author.id
    end

    def is_completed
      object.target_completed?
    end

  end
end
