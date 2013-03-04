require 'spec_helper'

describe "edit question" do
  it "should edit question" do
    question = FactoryGirl.create(:question, title: "jQuery", text: "How to insert text to textarea?")   
    
    visit question_path(question)
    
    page.should have_selector(".question .title", text: "jQuery")
    page.should have_selector(".question .text", text: "How to insert text to textarea?")
    
    click_link "Edit"

    fill_in "Title", with: "jQuery updated"
    fill_in "Text", with: "How to insert text to textarea? updated"
    click_button "Update Question"
    
    page.should have_selector("#notice", text: "Question was successfully updated.")
    page.should have_selector(".question .title", text: "jQuery updated")
    page.should have_selector(".question .text", text: "How to insert text to textarea? updated")
  end
  
end