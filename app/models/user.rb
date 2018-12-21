class User < ApplicationRecord
  # コールバックを定義
  before_save {self.email = email.downcase}
  # メソッドを定義
  has_secure_password
  # バリデーションを定義
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: Constants::VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
end
