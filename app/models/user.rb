class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :username, presence: true
  validates :password, presence: true
  validates :password_digest, presence: true
  # validates_associated :posts
end
