FactoryGirl.define do
	factory :question do
	  association :user
	  sequence(:title) { |n| "title-#{n}"}
	  sequence(:text) { |n| "text-#{n}"}
	end

	factory :user do
		sequence(:email) { |n| "email#{n}@mail.ru"}
    password "12345678"
    password_confirmation "12345678"
    sequence(:login) { |n| "login#{n}"}
    birth_date "1988-12-12".to_date
    country "Russia"
    city "Tambov"
    address "Lenin st, 23/54"
	end
end