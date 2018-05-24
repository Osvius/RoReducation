class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {in: 2..50}
  validates :text, presence: true, length: {in:1..1000}
end
