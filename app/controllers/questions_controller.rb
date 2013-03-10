class QuestionsController < ApplicationController
  load_and_authorize_resource :question, only: [:show, :destroy]
  load_and_authorize_resource :question, through: :current_user, only: [:edit, :new, :create, :update]

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
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @question.update_attributes(params[:question])
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_url
  end
end
