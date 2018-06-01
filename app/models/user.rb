class User < ApplicationRecord
  include EmailValidatable
  has_secure_password
  before_create :verify_token_generate
  attr_accessor :remember_token

  # has_many :posts
  #
  # enum role: [:user, :admin, :moderator]
  # after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true, uniqueness: true, length: {maximum: 50}, email: true
  validates :password, presence: true, confirmation: true, length: {in: 5..100}, on: [:create, :password_change]
  validates :password_confirmation, presence: true, on: [:create, :password_change]
  validates :first_name, length: {in: 2..100}, allow_blank: true
  validates :last_name, length: {in: 2..100}, allow_blank: true

  # def set_default_role
  #   self.role ||= :user
  # end

  def email_verify
    self.verified = true
    self.verify_token = nil
    save!(validate: false)
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)
  end

  def new_token
    SecureRandom.urlsafe_base64.to_s
  end

  def remember
    self.remember_token = self.new_token
    update_attribute(:remember_digest, self.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    def verify_token_generate
      if self.verify_token.blank?
        self.verify_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
