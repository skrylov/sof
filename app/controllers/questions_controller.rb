class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build

  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question_user = current_user
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    # @question.destroy if current_user.author_of?(@question)
    @question.destroy
    redirect_to questions_path
  end

  private

  # comment
  def question_params
    params.require(:question).permit(:title, :body)
  end

  def load_question
    @question = Question.find(params[:id])
  end
end
# class QuestionsController < ApplicationController
# before_action :authenticate_user!, except: [:index, :show]
# #before_action :load_question, only: [:show, :edit, :update, :destroy]
#   def index
#     @questions = Question.all
#   end
#
#   def show
#     @question = Question.find(params[:id])
#
#   end
#
#   def new
#     @question = Question.new
#   end
#
#   def edit
#     @question = Question.find(params[:id])
#   end
#
#   def create
#     @question = Question.new(question_params)
#     if @question.save
#       redirect_to @question, notice: 'Your question successfully created'
#     else
#       render :new
#     end
#   end
#
#   def update
#     if @question.update(question_params)
#       redirect_to @question
#     else
#       render :edit
#     end
#   end
#
# def destroy
#   if (user_signed_in? && current_user.id == @question.user_id)
#   @question.destroy
#   redirect_to questions_path
#   else
#   redirect_to questions_path
# end
#
#   private
#
#   def question_params
#     params.require(:question).permit(:title, :body)
#   end
#
#   def load_question
#     @question = Question.find(params[:id])
#   end
# end
# end
#