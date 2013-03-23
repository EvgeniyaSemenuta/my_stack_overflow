class Question < ActiveRecord::Base

	attr_accessible :title, :text, :tag_array

	acts_as_taggable

  belongs_to :user
	has_many :answers
  has_many :votes, as: :votable

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true

  def tag_array= tag_array
    self.tag_list = tag_array.join(", ")
  end
end
