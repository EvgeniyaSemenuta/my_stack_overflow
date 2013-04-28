class Answer < ActiveRecord::Base
	attr_accessible :text

	belongs_to :user
	belongs_to :question
  has_many :votes, as: :votable

  scope :ordered_by_rating, select("answers.id,
                                    answers.text,
                                    answers.user_id,
                                    answers.question_id,
                                    answers.created_at,
                                    answers.updated_at,
                                    coalesce(Sum(votes.rating), 0) as rating").
                      joins("LEFT JOIN votes ON votes.votable_id = answers.id AND votes.votable_type = 'Answer'").
                      group("answers.id,
                             answers.text,
                             answers.user_id,
                             answers.question_id,
                             answers.created_at,
                             answers.updated_at").order("rating DESC")

	validates :text, presence: true
	validates :user, presence: true
	validates :question, presence: true

  def rating
    self.votes.sum(:rating)
  end
end
