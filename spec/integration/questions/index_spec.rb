require 'spec_helper'
require 'integration/integration_helper'

describe "index questions page" do
  it "should display question information" do
    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

    visit questions_path

    page.should have_selector("#question_#{question.id} .title", text: "jQuery")
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