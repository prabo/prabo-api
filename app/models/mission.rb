class Mission < ApplicationRecord
  belongs_to :author, :class_name => 'User', :inverse_of => :missions, :foreign_key => 'user_id'
  has_many :completes
  has_many :completed_users, :through => :completes, :inverse_of => :completes_missions, :source => 'user'

  validates :title, presence: true
  validates :description, presence: true
end
