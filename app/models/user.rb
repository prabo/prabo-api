class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  after_create :update_access_token!
  has_many :missions, :dependent => :destroy, :inverse_of => :author, :foreign_key => 'user_id'
  has_many :completes
  has_many :completed_missions, :through => :completes, :inverse_of => :completed_users, :source => :mission

  validates :email, presence: true

  alias_attribute :created_missions, :missions

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  def complete(mission)
    !self.completed_missions.include?(mission) and self.completed_missions << mission
  end

  def uncomplete(mission)
    self.completed_missions.include?(mission) and self.completed_missions.destroy mission
  end
end
