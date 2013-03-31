class Vote < ActiveRecord::Base
  attr_accessible :positive, :negative

  belongs_to :user
  belongs_to :votable, polymorphic: true

  POSITIVE = 1
  NEGATIVE = -1
  RATINGS = [NEGATIVE, POSITIVE]

  validates :user, presence: true
  validates :votable, presence: true
  validates :rating, inclusion: { in: RATINGS }

  validate do
    if self.user.voted_for? self.votable
      errors.add(:vote, "already exist")
    end
  end

  def positive= positive
    self.rating = positive ? POSITIVE : NEGATIVE
  end

  def negative= negative
    self.rating = negative ? NEGATIVE : POSITIVE
  end
end
