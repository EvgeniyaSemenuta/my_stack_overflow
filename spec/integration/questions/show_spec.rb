require 'spec_helper'

describe "show question page" do
  it "should create new question" do
    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")   
    
    visit question_path(question)
    
    page.should have_selector(".question .title", text: "jQuery")
    page.should have_selector(".question .text", text: "How to insert text to textarea?") 
  end

end