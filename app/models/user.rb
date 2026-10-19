class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_digest, presence: true
  # validates_associated :posts
end
