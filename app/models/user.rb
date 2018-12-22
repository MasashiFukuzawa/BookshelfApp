class User < ApplicationRecord
  before_save {self.email = email.downcase}

  has_secure_password
  
  validates :name, presence: true, length: {maximum: 50}
  validates :email, email: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
end
