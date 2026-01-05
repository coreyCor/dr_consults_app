class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @consult = Consult.find(params[:consult_id])
    @answer = @consult.build_answer(answer_params)
    @answer.user = current_user

    if @answer.save
      @consult.update!(consult_status: Consult::STATUS_ANSWERED)
      redirect_to @consult, notice: "Answer submitted successfully."
    else
      render "consults/show", status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
