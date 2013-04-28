desc "Populate test data"
task populate_test_data: :environment do
  FactoryGirl.create(:admin, login: "admin", email: "admin@mailinator.com")
  FactoryGirl.create(:moderator, login: "moderator", email: "moderator@mailinator.com")
  tags = ["critical", "issue", "bug", "test", "task"]
  questions = []
  30.times do
    questions << FactoryGirl.create(:question, tag_list: [tags.sample, tags.sample].join(', '))
  end

  questions.each do |question|
    answers = FactoryGirl.create_list(:answer, 3, question: question)
    FactoryGirl.create_list(:vote, 2, votable: question)
    FactoryGirl.create_list(:vote, 2, votable: answers[0])
    FactoryGirl.create_list(:review, 2, question: question)
  end
end