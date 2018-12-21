class User < ApplicationRecord
  # コールバックを定義
  before_save {self.email = email.downcase}
  
  # バリデーションを定義
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: Constants::VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  # Railsメソッドの呼出し
  has_secure_password

  # メソッドを定義
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end