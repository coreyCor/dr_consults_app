class ConsultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consult, only: [ :show, :edit, :update, :destroy ]

  # GET /consults
  def index
    @consults = Consult.all.order(created_at: :desc)
  end

  # GET /consults/new
  def new
    @consult = Consult.new
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)
  end

  # POST /consults
  def create
    @consult = current_user.asked_consults.build(consult_params)
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)

    assigned_user = User.find_by(id: @consult.assigned_to_id)

    if assigned_user.nil? || !@eligible_users.include?(assigned_user)
      flash[:alert] = assigned_user ? "#{assigned_user.name} is currently unavailable for a new consult." : "Please select a valid doctor."
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
    # @question = current_user.questions.find(params[:id])
  end

  # GET /consults/:id/edit
  def edit
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)
  end

  # PATCH/PUT /consults/:id
  def update
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)

    assigned_user = User.find_by(id: consult_params[:assigned_to_id])
    if assigned_user.nil? || !@eligible_users.include?(assigned_user)
      flash[:alert] = assigned_user ? "#{assigned_user.name} is currently unavailable." : "Please select a valid doctor."
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

  private

  def set_consult
    @consult = Consult.find(params[:id])
  end

  def consult_params
    params.require(:consult).permit(:title, :body, :assigned_to_id)
  end
end
