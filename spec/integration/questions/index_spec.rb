require 'spec_helper'
require 'integration/integration_helper'

describe "index questions page" do
  it "should display question information" do
    user = FactoryGirl.create(:user, login: "john")
    question = FactoryGirl.create(:question, user: user, title: "jQuery", text: "How to insert text to textarea?", tag_list: "tag1, tag2")

    visit questions_path

    page.should have_selector("#question_#{question.id} .title", text: "jQuery")
    page.should have_selector("#question_#{question.id} .tags", text: "tag2 tag1")
    page.should have_selector("#question_#{question.id} .user", text: "john")
  end

  it "should display reviews count" do
    question1 = FactoryGirl.create(:question)
    FactoryGirl.create(:review, question: question1)
    FactoryGirl.create(:review, question: question1)

    question2 = FactoryGirl.create(:question)
    FactoryGirl.create(:review, question: question2)

    visit questions_path

    page.should have_selector("#question_#{question1.id} .reviews", text: "2")
    page.should have_selector("#question_#{question2.id} .reviews", text: "1")
  end

  it "should change review count" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, title: "Some question")

    sign_in user
    visit questions_path

    page.should have_selector("#question_#{question.id} .reviews", text: "0")

    within("#question_#{question.id} .title") do
      click_link "Some question"
    end

    click_link "Questions"

    page.should have_selector("#question_#{question.id} .reviews", text: "1")
  end

  it "should not change review count for guest" do
    question = FactoryGirl.create(:question, title: "Some question")

    visit questions_path

    page.should have_selector("#question_#{question.id} .reviews", text: "0")

    within("#question_#{question.id} .title") do
      click_link "Some question"
    end

    click_link "Questions"

    page.should have_selector("#question_#{question.id} .reviews", text: "0")
  end

  it "should not change review count twice for user" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, title: "Some question")
    FactoryGirl.create(:review, question: question, user: user)

    sign_in user
    visit questions_path

    page.should have_selector("#question_#{question.id} .reviews", text: "1")

    within("#question_#{question.id} .title") do
      click_link "Some question"
    end

    click_link "Questions"

    page.should have_selector("#question_#{question.id} .reviews", text: "1")
  end

  it "should display all questions" do
  	question1 = FactoryGirl.create(:question, title: "jQuery")
    question2 = FactoryGirl.create(:question, title: "PHP")

    visit questions_path

    page.should have_selector("#question_#{question1.id} .title", text: "jQuery")
    page.should have_selector("#question_#{question2.id} .title", text: "PHP")
	end

  it "should filter questions by tag" do
    question1 = FactoryGirl.create(:question, title: "jQuery", tag_list: "tag1")
    question2 = FactoryGirl.create(:question, title: "PHP", tag_list: "tag2")

    visit questions_path

    within("#tag_cloud") do
      click_link "tag1"
    end

    page.should have_selector("#question_#{question1.id} .title", text: "jQuery")
    page.should_not have_selector("#question_#{question2.id} .title", text: "PHP")
  end

end