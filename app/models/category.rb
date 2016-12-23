class Category < ApplicationRecord
  has_many :missions, :dependent => :delete_all
end
