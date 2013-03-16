class QuestionsController < ApplicationController
  load_and_authorize_resource :question, only: [:show, :destroy, :edit, :update]
  load_and_authorize_resource :question, through: :current_user, only: [:new, :create]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @question.save
      flash[:notice] = "Question was successfully created."
      render :show
    else
      render :new
    end
  end

  def update
    if @question.update_attributes(params[:question])
      flash[:notice] = 'Question was successfully updated.'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_url
  end
end
