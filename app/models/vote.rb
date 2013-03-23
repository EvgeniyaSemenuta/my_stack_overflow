class Vote < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user, presence: true
  validates :votable, presence: true
  validates :rating, inclusion: { in: [-1, 1] }

end
