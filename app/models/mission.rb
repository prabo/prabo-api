class Mission < ApplicationRecord
  belongs_to :author, :class_name => 'User', :inverse_of => :missions

  validates :title, presence: true
  validates :description, presence: true
end
