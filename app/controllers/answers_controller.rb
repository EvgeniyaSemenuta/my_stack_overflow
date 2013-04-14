class AnswersController < ApplicationController
  load_and_authorize_resource :question
  load_and_authorize_resource :answer, through: :question

  def create
    @answer.user = current_user
    if @answer.save
      render partial: "answer", locals: {answer: @answer}, content_type: 'text/html'
    end
  end

  def edit
  end

  def update
    if @answer.update_attributes(params[:answer])
      redirect_to @question, notice: 'Answer was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @answer.destroy

    redirect_to @question
  end
end
