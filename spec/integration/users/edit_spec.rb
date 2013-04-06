require 'spec_helper'
require 'integration/integration_helper'

describe "edit user page" do
  it "should edit user" do
    user = FactoryGirl.create(:user, login: "Jack",
                                     email: "jack@gmail.com",
                                     birth_date: "1987-12-01".to_date,
                                     country: "Canada",
                                     city: "Ottawa",
                                     address: "Lights st., 24/12")
    sign_in(user)

    visit user_path(user)

    page.should have_selector(".user .login", text: "Jack")
    page.should have_selector(".user .birth_date", text: "1987-12-01")
    page.should have_selector(".user .country", text: "Canada")
    page.should have_selector(".user .city", text: "Ottawa")
    page.should have_selector(".user .address", text: "Lights st., 24/12")

    click_link "Edit"

    fill_in "Login", with: "John"
    select "1986", from: "user_birth_date_1i"
    select "April", from: "user_birth_date_2i"
    select "2", from: "user_birth_date_3i"

    fill_in "Country", with: "China"
    fill_in "City", with: "Pekin"
    fill_in "Address", with: "Dark av., 12/10"
    click_button "Update User"

    page.should have_selector(".user .login", text: "John")
    page.should have_selector(".user .birth_date", text: "1986-04-02")
    page.should have_selector(".user .country", text: "China")
    page.should have_selector(".user .city", text: "Pekin")
    page.should have_selector(".user .address", text: "Dark av., 12/10")
  end

  it "should edit user role" do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    sign_in(admin)

    visit user_path(user)

    page.should_not have_selector(".user .role")

    click_link "Edit"

    select "moderator", from: "user_role"
    click_button "Update Role"

    page.should have_selector("#notice", text: "User role was successfully updated.")
    page.should have_selector(".user .role", text: "moderator")
  end

  it "shouldn't show role form" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    visit edit_user_path(user)

    page.should_not have_selector("#edit_role")
  end
end