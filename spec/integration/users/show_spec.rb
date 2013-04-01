require 'spec_helper'
require 'integration/integration_helper'

describe "show user page" do
  it "should display all information of user" do
    user = FactoryGirl.create(:user, login: "Jack",
                                     email: "jack@gmail.com",
                                     birth_date: "1987-12-01".to_date,
                                     country: "Canada",
                                     city: "Ottawa",
                                     address: "Lights st., 24/12")
    visit user_path(user)

    page.should have_selector(".user .login", text: "Jack")
    page.should have_selector(".user .email", text: "jack@gmail.com")
    page.should have_selector(".user .birth_date", text: "1987-12-01")
    page.should have_selector(".user .country", text: "Canada")
    page.should have_selector(".user .city", text: "Ottawa")
    page.should have_selector(".user .address", text: "Lights st., 24/12")
  end
end
