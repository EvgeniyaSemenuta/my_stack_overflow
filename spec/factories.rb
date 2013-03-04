FactoryGirl.define do
	factory :question do
	  sequence(:title) { |n| "title-#{n}"}
	  sequence(:text) { |n| "text-#{n}"}
	end
end