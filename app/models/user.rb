class User < ApplicationRecord
  include EmailValidatable
  has_secure_password
  before_create :verify_token_generate

  # has_many :posts
  #
  # enum role: [:user, :admin, :moderator]
  # after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true, uniqueness: true, length: {maximum: 50}, email: true
  validates :password, presence: true, confirmation: true, length: {in: 5..100}
  validates :password_confirmation, presence: true
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

  private

    def verify_token_generate
      if self.verify_token.blank?
        self.verify_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
