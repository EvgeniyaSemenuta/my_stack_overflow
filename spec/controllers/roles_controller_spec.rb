require 'spec_helper'

describe RolesController do

  context "[authorization]" do
    let(:user) {FactoryGirl.create :user}
    let(:moderator) {FactoryGirl.create :moderator}
    let(:admin) {FactoryGirl.create :admin}

    context "[update]" do
      it "should not allow access for user" do
        sign_in user

        put :update, user_id: user.id, user: {role: "admin"}
        response.should be_forbidden
      end

      it "should not allow access for moderator" do
        sign_in moderator

        put :update, user_id: user.id, user: {role: "admin"}
        response.should be_forbidden
      end

      it "should allow access for admin" do
        sign_in admin

        put :update, user_id: user.id, user: {role: "admin"}
        response.should redirect_to(user_path(user))
      end

      it "should not allow access for guest" do
        put :update, user_id: user.id, user: {role: "admin"}
        response.should be_forbidden
      end
    end
  end
end