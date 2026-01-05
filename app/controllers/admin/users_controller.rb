
class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [ :edit, :update, :destroy ] # remove :show

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end
  def weekly_schedule
  @users = User.includes(:availabilities).all
  @days_of_week = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  end


    # weekly is used to show week to admin -> quick view. TODO, set time from here too!
    def weekly_schedule
      # Load all users with their availabilities
      @users = User.includes(:availabilities).all
       # Days of the week for header
       @days_of_week = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def user_params
  params.require(:user).permit(
    :name, :email, :user_role, :daily_consult_limit, :cooldown_minutes, :time_zone,
    availabilities_attributes: [ :id, :day_of_week, :start_time, :end_time, :start_minute, :end_minute, :_destroy ]
  )
  end
end
