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

  def positive= positive
    self.rating = positive ? POSITIVE : NEGATIVE
  end

  def negative= negative
    self.rating = negative ? NEGATIVE : POSITIVE
  end
end
