class AnswersController < ApplicationController
  load_resource :question
  load_resource :answer, through: :question, only: :create

  def create
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: 'Answer was successfully created.'
    end
  end

end
