class QuizzesController < ApplicationController
  include AuthRequired
  include AccessControl

  before_action :find_quiz, only: %i[show edit update destroy]

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_attributes)
    @quiz.user = current_user

    if @quiz.save
      flash[:notice] =
        "Quiz created. Use this link to share: #{quiz_url(@quiz.id)}"
      render status: 201, json: { location: quiz_path(@quiz.id) }
    else
      render status: 400, json: { errors: @quiz.errors.full_messages }
    end
  end

  def edit
    ensure_owner!(@quiz.user)
  end

  def update
    ensure_owner!(@quiz.user)

    if @quiz.update_attributes(quiz_attributes)
      flash[:notice] =
        "Quiz updated. Use this link to share: #{quiz_url(@quiz.id)}"
      render status: 200, json: { location: quiz_path(@quiz.id) }
    else
      render status: 400, json: { errors: @quiz.errors.full_messages }
    end
  end

  def destroy
    ensure_owner!(@quiz.user)

    @quiz.mark_as_deleted!

    flash[:notice] = "Quiz #{@quiz.title} has been deleted."
    redirect_to dashboard_path
  end

  protected

  def quiz_attributes
    params.permit(
      :title,
      :description,
      content: { questions: [:question, :answer] }
    )
  end

  def find_quiz
    @quiz = Quiz.existing.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound if @quiz.nil?
  end
end
