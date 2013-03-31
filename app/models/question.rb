class Question < ActiveRecord::Base

	attr_accessible :title, :text

	belongs_to :user
	has_many :answers

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true
end
