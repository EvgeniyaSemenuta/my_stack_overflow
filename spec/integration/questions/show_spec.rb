require 'spec_helper'
require 'integration/integration_helper'

describe "show question page" do
  it "should display all information of question" do
    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

    visit question_path(question)

    page.should have_selector(".question .title", text: "jQuery")
    page.should have_selector(".question .text", text: "How to insert text to textarea?")
  end

  it "should display question's tags" do
    question = FactoryGirl.create(:question, tag_list: "tag1, tag2")
    FactoryGirl.create(:question, tag_list: "tag3")

    visit question_path(question)

    page.should have_selector("#tags", text: "tag1")
    page.should have_selector("#tags", text: "tag2")
    page.should_not have_selector("#tags", text: "tag3")
  end

  context "[votes]" do
    it "should create positive vote", js: true do
      user = FactoryGirl.create :user
      sign_in user

      question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

      visit question_path(question)

      page.should have_selector(".question .rating", text: "0")

      within(".question .rating") do
        click_button "+"
      end

      page.should have_selector(".question .rating", text: "1")
    end

    it "should create negative vote", js: true do
      user = FactoryGirl.create :user
      sign_in user

      question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

      visit question_path(question)

      page.should have_selector(".question .rating", text: "0")

      within(".question .rating") do
        click_button "-"
      end

      page.should have_selector(".question .rating", text: "-1")
    end

    it "should not display vote form for alredy voted user" do
      user = FactoryGirl.create :user
      sign_in user

      question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
      vote = FactoryGirl.create(:vote, user: user, votable: question)

      visit question_path(question)

      page.should_not have_selector(".question .rating form")
    end

    it "should not display vote form for guest" do
      question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
      visit question_path(question)
      page.should_not have_selector(".question .rating form")
    end
  end

  context "[answers]" do
		it "should create new answer", js: true do
		  user = FactoryGirl.create :user
		  sign_in user

	    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

	    visit question_path(question)

	    fill_in "answer_text", with: "It's easy"
	    click_button "Create Answer"

	    page.should have_selector("#answers .text", text: "It's easy")
	  end

	  it "should show all question answers" do
	  	question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
	    answer1 = FactoryGirl.create(:answer, question: question, text: "It's easy")
	  	answer2 = FactoryGirl.create(:answer, question: question, text: "It's hard")
	  	answer3 = FactoryGirl.create(:answer)

	  	visit question_path(question)

	  	page.should have_selector("#answer_#{answer1.id}", text: "It's easy")
	  	page.should have_selector("#answer_#{answer2.id}", text: "It's hard")
	  	page.should_not have_selector("#answer_#{answer3.id}")
	  end

    context "[moderating]" do
      before do
        @moderator = FactoryGirl.create(:moderator)
        sign_in(@moderator)
      end

      it "should update the answer" do
        question = FactoryGirl.create(:question)
  	 	  answer = FactoryGirl.create(:answer, question: question, text: "hello")

  	    visit question_path(question)

  	    page.should have_selector("#answer_#{answer.id} .text", text: "hello")

  	    within("#answer_#{answer.id}") do
        	click_link "Edit"
        end

  	    fill_in "answer_text", with: "good bye"
  	    click_button "Update Answer"

  	    page.should have_selector("#notice", text: "Answer was successfully updated.")
  	    page.should have_selector("#answer_#{answer.id} .text", text: "good bye")
  	  end

  		it "should destroy the answer" do
        question = FactoryGirl.create(:question)
  	 	  answer = FactoryGirl.create(:answer, question: question)

  	    visit question_path(question)

  	    within("#answer_#{answer.id}") do
        	click_link "Destroy"
        end

  	    page.should_not have_selector("#answer_#{answer.id}")
  	  end
    end

    context "[votes]" do
      it "should create positive vote", js: true do
        user = FactoryGirl.create :user
        sign_in user

        question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
        answer = FactoryGirl.create(:answer, question: question)

        visit question_path(question)

        page.should have_selector("#answer_#{answer.id} .rating", text: "0")

        within("#answer_#{answer.id} .rating") do
          click_button "+"
        end

        page.should have_selector("#answer_#{answer.id} .rating", text: "1")
      end

      it "should create negative vote", js: true do
        user = FactoryGirl.create :user
        sign_in user

        question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
        answer = FactoryGirl.create(:answer, question: question)

        visit question_path(question)

        page.should have_selector("#answer_#{answer.id} .rating", text: "0")

        within("#answer_#{answer.id} .rating") do
          click_button "-"
        end

        page.should have_selector("#answer_#{answer.id} .rating", text: "-1")
      end

      it "should not display vote form for alredy voted user" do
        user = FactoryGirl.create :user
        sign_in user

        question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
        answer = FactoryGirl.create(:answer, question: question)
        vote = FactoryGirl.create(:vote, user: user, votable: answer)

        visit question_path(question)

        page.should_not have_selector("#answer_#{answer.id} .rating form")
      end

      it "should not display vote form for guest" do
        question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")
        answer = FactoryGirl.create(:answer, question: question)
        visit question_path(question)
        page.should_not have_selector("#answer_#{answer.id} .rating form")
      end
    end
	end
end