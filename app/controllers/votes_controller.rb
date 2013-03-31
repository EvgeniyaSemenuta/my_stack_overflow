class VotesController < ApplicationController
  load_resource :question
  load_resource :answer
  load_and_authorize_resource :vote, through: :current_user

  def create
    @vote.votable = @question || @answer
    if @vote.save
      flash[:notice] = "You voted."
      redirect_to question_path(@question || @answer.question)
    end
  end
end
