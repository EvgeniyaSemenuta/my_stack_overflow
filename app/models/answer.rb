class Answer < ActiveRecord::Base
	attr_accessible :text

	belongs_to :user
	belongs_to :question
  has_many :votes, as: :votable

	validates :text, presence: true
	validates :user, presence: true
	validates :question, presence: true

  def rating
    self.votes.sum(:rating)
  end
end
