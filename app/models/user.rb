class User < ApplicationRecord
  include EmailValidatable
  has_secure_password
  before_create :verify_token_generate
  attr_accessor :remember_token, :old_password
  mount_uploader :avatar, AvatarUploader

  validate :is_user_password, on: [:password_change]
  # attr_reader :old_password
  # self.abstract_class = true

  # has_many :posts
  #
  # enum role: [:user, :admin, :moderator]
  # after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true, uniqueness: true, length: {maximum: 50}, email: true, on: :create
  validates :password, presence: true, confirmation: true, length: {in: 5..100}, on: [:create, :password_change]
  validates :password_confirmation, presence: true, on: [:create, :password_change]
  validates :first_name, length: {in: 2..100}, allow_blank: true
  validates :last_name, length: {in: 2..100}, allow_blank: true
  validates :old_password, presence: true, on: [:password_change]
  validates :avatar, file_size: { less_than: 5.megabytes }

  # def set_default_role
  #   self.role ||= :user
  # end

  def update_with_context(attributes, context)
    with_transaction_returning_status do
      assign_attributes(attributes)
      save(context: context)
    end
  end

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

  def is_user_password
    if old_password.present? && !User.find_by(id: self.id).authenticate(old_password)
      errors.add(:old_password, "Incorrect")
    end
  end

end
