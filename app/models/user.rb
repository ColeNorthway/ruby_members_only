class User < ApplicationRecord
  has_many :posts
  validates :username, presence: true
  validates :password, presence: true
  # validates_associated :posts
end
