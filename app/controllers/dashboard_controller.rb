class DashboardController < ApplicationController
  include AuthRequired

  def show
    @latest_quizzes = Quiz.order('created_at DESC').limit(20)
  end
end
