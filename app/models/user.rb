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
  has_many :votes

  ADMIN = 'admin'
  MODERATOR = 'moderator'
  USER = 'user'
  ROLES = [ADMIN, MODERATOR, USER]

  validates :login, presence: true
  validates :role, inclusion: { in: ROLES }, allow_nil: true

  def admin?
    self.role == ADMIN
  end

  def moderator?
    self.role == MODERATOR
  end

  def user?
    self.role.nil? || self.role == USER
  end

  def voted_for? votable
    self.votes.find_by_votable_id_and_votable_type(votable.id, votable.class.to_s).present?
  end
end
