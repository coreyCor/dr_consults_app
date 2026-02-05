class UsersController < ApplicationController
  before_action :authenticate_user!

  # Returns the full availability card (for the cards view)
  def availability
    @user = User.find(params[:id])
    response.headers["Cache-Control"] = "no-store"
    @eligible_users = User.eligible_for_consults(exclude_user: current_user)
    render partial: "users/availability_card", locals: { user: @user, eligible_users: @eligible_users }
  end

 # Returns the table row content (for table view)
 def availability_row
  @user = User.find(params[:id])
  @eligible_users = User.eligible_for_consults(exclude_user: current_user)

   response.headers["Cache-Control"] = "no-store"

  render partial: "consults/user_row",
         locals: { user: @user, eligible_users: @eligible_users }
 end
end
