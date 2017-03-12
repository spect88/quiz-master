class ResultsController < ApplicationController
  include AuthRequired

  def create
    quiz = Quiz.find(params[:quiz_id])
    result = quiz.submit_answers(answers: params[:answers], user: current_user)
    render json: result
  end
end
