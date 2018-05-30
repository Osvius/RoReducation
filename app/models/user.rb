class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include EmailValidatable
  # has_many :posts
  #
  # enum role: [:user, :admin, :moderator]
  # after_initialize :set_default_role, :if => :new_record?

  validates :email, presence: true, uniqueness: true, length: {maximum: 50}, email:true
  validates :password, presence: true, confirmation: true
  validates :first_name, length: {in: 2..100}, allow_blank: true
  validates :last_name, length: {in: 2..100}, allow_blank: true

  # def set_default_role
  #   self.role ||= :user
  # end
end
