class Mission < ApplicationRecord
  belongs_to :author, :class_name => 'User', :inverse_of => :missions, :foreign_key => 'user_id'

  validates :title, presence: true
  validates :description, presence: true
end
