class Api::QuestionsController < ApplicationController
  load_resource :question, only: [:index, :show]

  def index
    respond_to do |format|
      format.json do
        render json: @questions.as_json(only: [:id, :title, :text])
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: @question.as_json(only: [:id, :title, :text],
                                       include: {answers: {only: [:id, :text]}})
      end
    end
  end

end