require 'spec_helper'
require 'integration/integration_helper'

describe "new question page" do
  before do
    user = FactoryGirl.create :user
    sign_in user
  end

  it "should create new question" do
    visit new_question_path

    fill_in "Title", with: "jQuery"
    fill_in "Text", with: "How to insert text to textarea?"
    click_button "Create Question"

    page.should have_selector("#notice", text: "Question was successfully created.")
    page.should have_selector(".question .title", text: "jQuery")
  end

  it "should validate question" do
    visit new_question_path

    click_button "Create Question"

    page.should have_selector("#error_explanation", text: "Title can't be blank")
    page.should have_selector("#error_explanation", text: "Text can't be blank")
  end

end