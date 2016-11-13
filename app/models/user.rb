class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  after_create :update_access_token!
  has_many :missions, :dependent => :destroy, :inverse_of => :author
  has_many :completes
  has_many :completed_missions, :through => :completes, :inverse_of => :completed_users, :source => 'mission'

  validates :email, presence: true

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end
end
