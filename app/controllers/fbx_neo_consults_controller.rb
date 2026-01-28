class FbxNeoConsultsController < ApplicationController
  before_action :authenticate_user!

  def new
    @consult = Consult.new(consult_type: "fbx_neo")
    @eligible_users = User.eligible_for_fbx_neo(exclude_user: current_user)
  end

  def create
    @consult = current_user.asked_consults.build(consult_params)
    @consult.consult_type = "fbx_neo"

    selected_users = User.where(
      id: params[:assigned_user_ids]
    )

    if selected_users.size < 2 || selected_users.size > 5
      flash.now[:alert] = "Please select between 2 and 5 users."
      @eligible_users = User.where(can_accept_fbx_neo: true).(exclude_user: current_user)
      render :new, status: :unprocessable_entity
      return
    end

    if @consult.save
      @consult.assign_users!(selected_users)
      redirect_to mine_fbx_neo_consults_path, notice: "FBX NEO created successfully."
    else
      @eligible_users = User.eligible_for_fbx_neo(exclude_user: current_user)

      render :new, status: :unprocessable_entity
    end
  end

  def mine
    @consults =
      current_user.fbx_neo_consults
                  .where(consult_type: Consult::FBX_NEO)
                  .distinct
                  .order(created_at: :desc)
  end


  def show
  @consult = Consult.find(params[:id])

  unless @consult.consult_type == Consult::FBX_NEO &&
         (@consult.asked_by == current_user ||
          @consult.assigned_users.include?(current_user))
    redirect_to root_path, alert: "You are not authorized to view this FBX NEO."
  end
  end


  private

  def consult_params
    params.require(:consult).permit(:title, :body)
  end
end
