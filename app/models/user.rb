class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  								:login, :birth_date, :country, :city, :address

  has_many :questions
  has_many :answers

  ROLES = ['admin', 'moderator']

  validates :login, presence: true
  validates :role, inclusion: { in: ROLES }, allow_nil: true
end
