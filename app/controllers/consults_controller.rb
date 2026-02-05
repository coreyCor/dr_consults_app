class ConsultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consult, only: [ :show, :edit, :update, :destroy ]
  before_action :set_eligible_users, only: [ :new, :create, :edit, :update ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]

  # GET /consults
  def index
    # @consults = current_user.asked_consults.order(created_at: :desc)
  end

  # GET /consults/new
  # def new
  # @consult = Consult.new
  # end
  #
  def new
  @consult = Consult.new

  # Preassign the "assigned_to" user if passed from the schedule view
  if params[:assigned_to_id].present?
    @consult.assigned_to_id = params[:assigned_to_id]
  end
  end


  # POST /consults
  def create
    @consult = current_user.asked_consults.build(consult_params)
    @consult.consult_status ||= Consult::STATUS_PENDING
    assigned_user = User.find_by(id: @consult.assigned_to_id)

    if assigned_user.nil? || !@eligible_users.include?(assigned_user)
      flash[:alert] = assigned_user ? "#{assigned_user.name} is unavailable" : "Select a valid doctor."
      render :new, status: :unprocessable_entity and return
    end

    @consult.assigned_at = Time.current if @consult.assigned_to_id.present?

    if @consult.save
      flash[:notice] = "Consult created successfully."
      redirect_to @consult
    else
      flash.now[:alert] = "Failed to create consult."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /consults/:id
  def show
    @answer = @consult.answer || Answer.new
  end

  # GET /consults/:id/edit
  def edit; end

  # PATCH/PUT /consults/:id
  def update
    assigned_user = User.find_by(id: consult_params[:assigned_to_id])
    if assigned_user.nil? || !@eligible_users.include?(assigned_user)
      flash[:alert] = assigned_user ? "#{assigned_user.name} is unavailable" : "Select a valid doctor."
      render :edit, status: :unprocessable_entity and return
    end

    if @consult.update(consult_params)
      flash[:notice] = "Consult updated successfully."
      redirect_to @consult
    else
      flash.now[:alert] = "Failed to update consult."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /consults/:id
  def destroy
    if @consult.asked_by == current_user
      @consult.destroy
      flash[:notice] = "Consult deleted."
    else
      flash[:alert] = "You cannot delete this consult."
    end
    redirect_to consults_path
  end

  # GET /consults/mine
  def mine
    @consults = current_user.asked_consults.order(created_at: :desc)
  end

  # GET /consults/assigned
  def assigned
    @consults = current_user.assigned_consults.order(created_at: :desc)
  end

   def schedule
    # Show all users who can receive consults, regardless of current minute
    @eligible_users = User.where.not(id: current_user.id)
                          .receiving_consults
                          .includes(:availabilities)
  end

  private

  def set_consult
    @consult = Consult.find(params[:id])
  end

  def consult_params
    params.require(:consult).permit(:title, :body, :assigned_to_id)
  end

  def set_eligible_users
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)
  end

    def authorize_owner!
    unless @consult.asked_by_id == current_user.id
      redirect_to consults_path, alert: "You are not authorized to modify this consult."
    end
    end
end
