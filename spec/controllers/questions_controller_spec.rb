require 'spec_helper'

describe QuestionsController do

  context "[authorization]" do
    let(:user) {FactoryGirl.create :user}
    let(:moderator) {FactoryGirl.create :moderator}
    let(:admin) {FactoryGirl.create :admin}

    context "[index]" do
      it "should allow access for user" do
        sign_in user

        get :index
        response.should be_success
      end

      it "should allow access for moderator" do
        sign_in moderator

        get :index
        response.should be_success
      end

      it "should allow access for admin" do
        sign_in admin

        get :index
        response.should be_success
      end

      it "should allow access for guest" do
        get :index
        response.should be_success
      end
    end

    context "[show]" do
      it "should allow access for user" do
        question = FactoryGirl.create(:question)
        sign_in user

        get :show, id: question.id
        response.should be_success
      end

      it "should allow access for moderator" do
        question = FactoryGirl.create(:question)
        sign_in moderator

        get :show, id: question.id
        response.should be_success
      end

      it "should allow access for admin" do
        question = FactoryGirl.create(:question)
        sign_in admin

        get :show, id: question.id
        response.should be_success
      end

      it "should allow access for guest" do
        question = FactoryGirl.create(:question)

        get :show, id: question.id
        response.should be_success
      end
    end

    context "[new]" do
      it "should allow access for user" do
        sign_in user

        get :new
        response.should be_success
      end

      it "should allow access for moderator" do
        sign_in moderator

        get :new
        response.should be_success
      end

      it "should allow access for admin" do
        sign_in admin

        get :new
        response.should be_success
      end

      it "should not allow access for guest" do
        get :new
        response.should be_forbidden
      end
    end

    context "[create]" do
      it "should allow access for user" do
        sign_in user

        post :create, question: {title: "title", text: "text"}
        response.should be_success
      end

      it "should allow access for moderator" do
        sign_in moderator

        post :create, question: {title: "title", text: "text"}
        response.should be_success
      end

      it "should allow access for admin" do
        sign_in admin

        post :create, question: {title: "title", text: "text"}
        response.should be_success
      end

      it "should not allow access for guest" do
        post :create, question: {title: "title", text: "text"}
        response.should be_forbidden
      end
    end

    context "[edit]" do
      it "should not allow access for user" do
        question = FactoryGirl.create(:question)

        sign_in user

        get :edit, id: question.id
        response.should be_forbidden
      end

      it "should allow access for owner" do
        question = FactoryGirl.create(:question, user: user)

        sign_in user

        get :edit, id: question.id
        response.should be_success
      end

      it "should allow access for moderator" do
        question = FactoryGirl.create(:question)
        sign_in moderator

        get :edit, id: question.id
        response.should be_success
      end

      it "should not allow access for admin" do
        question = FactoryGirl.create(:question)
        sign_in admin

        get :edit, id: question.id
        response.should be_forbidden
      end

      it "should not allow access for guest" do
        question = FactoryGirl.create(:question)

        get :edit, id: question.id
        response.should be_forbidden
      end
    end

    context "[update]" do
      it "should not allow access for user" do
        question = FactoryGirl.create(:question)

        sign_in user

        put :update, id: question.id, question: {title: "head", text: "?"}
        response.should be_forbidden
      end

      it "should allow access for owner" do
        question = FactoryGirl.create(:question, user: user)

        sign_in user

        put :update, id: question.id, question: {title: "head", text: "?"}
        response.should be_success
      end

      it "should allow access for moderator" do
        question = FactoryGirl.create(:question)
        sign_in moderator

        put :update, id: question.id, question: {title: "head", text: "?"}
        response.should be_success
      end

      it "should not allow access for admin" do
        question = FactoryGirl.create(:question)
        sign_in admin

        put :update, id: question.id, question: {title: "head", text: "?"}
        response.should be_forbidden
      end

      it "should not allow access for guest" do
        question = FactoryGirl.create(:question)

        put :update, id: question.id, question: {title: "head", text: "?"}
        response.should be_forbidden
      end
    end

    context "[destroy]" do
      it "should not allow access for user" do
        question = FactoryGirl.create(:question)

        sign_in user

        delete :destroy, id: question.id
        response.should be_forbidden
      end

      it "should not allow access for owner" do
        question = FactoryGirl.create(:question, user: user)

        sign_in user

        delete :destroy, id: question.id
        response.should be_forbidden
      end

      it "should allow access for moderator" do
        question = FactoryGirl.create(:question)
        sign_in moderator

        delete :destroy, id: question.id
        response.should redirect_to(questions_path)
      end

      it "should not allow access for admin" do
        question = FactoryGirl.create(:question)
        sign_in admin

        delete :destroy, id: question.id
        response.should be_forbidden
      end

      it "should not allow access for guest" do
        question = FactoryGirl.create(:question)

        delete :destroy, id: question.id
        response.should be_forbidden
      end
    end
  end

end