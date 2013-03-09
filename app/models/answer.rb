class Answer < ActiveRecord::Base
	attr_accessible :text

	belongs_to :user
	belongs_to :question

	validates :text, presence: true
	validates :user, presence: true
	validates :question, presence: true
end
