class VotesController < ApplicationController
  load_resource :question
  load_resource :answer
  load_and_authorize_resource :vote, through: :current_user

  def create
    @vote.votable = @question || @answer
    if @vote.save
      render json: {rating: @vote.votable.rating}
    else
      render json: true, status: 500
    end
  end
end
