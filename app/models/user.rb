class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts

  enum role: [:user, :admin, :moderator]
  after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true, format: { with: Devise.email_regexp, message: "Invalid email"}, uniqueness: true
  validates :name, length: {maximum:100}
  validates :surname, length: {maximum:100}

  def set_default_role
    self.role ||= :user
  end
end
