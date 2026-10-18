class Post < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
