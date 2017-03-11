class QuizzesController < ApplicationController
  include AuthRequired

  def show
    @quiz = Quiz.find(params[:id])
  end
end
