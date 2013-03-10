require 'spec_helper'

describe "destroy question" do

  before do
    @moderator = FactoryGirl.create(:moderator)
    sign_in(@moderator)
  end

  it "should destroy question" do
    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")

    visit questions_path

    within("#question_#{question.id}") do
      click_link "Destroy"
    end

    page.should_not have_selector("#question_#{question.id}")
  end

end