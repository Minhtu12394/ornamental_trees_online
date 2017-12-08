class User < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  has_many :orders
  has_many :reviews
  has_many :carts
  has_secure_password

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    	BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    	BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
