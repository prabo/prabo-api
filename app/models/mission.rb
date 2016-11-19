class Mission < ApplicationRecord
  belongs_to :author, :class_name => 'User', :inverse_of => :missions, :foreign_key => 'user_id'
  has_many :completes
  has_many :completed_users, :through => :completes, :inverse_of => :completed_missions, :source => :user

  validates :title, presence: true
  validates :description, presence: true

  def set_target_user(user)
    @target_user = user
  end

  def target_completed?
    self.completed_users.include? @target_user
  end
end
