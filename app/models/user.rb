class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_digest, presence: true
  validate :password_complexity

  private

  def password_complexity
    if password.present? and !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{12,}$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, one digit, and needs to be minimum 12 characters."
    end
  end
end
