class Question < ActiveRecord::Base

	attr_accessible :title, :text

	belongs_to :user

  validates :title, presence: true
  validates :text, presence: true
  validates :user, presence: true
end
