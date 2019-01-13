class Book < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 800}

  mount_uploader :picture
end
