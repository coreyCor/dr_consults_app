class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @consults = Consult.includes(:asked_by, :assigned_to, :consult_assignments)
                       .order(created_at: :desc)

    today = Time.current.beginning_of_day..Time.current.end_of_day
    @total_today   = Consult.where(created_at: today).count
    @answered      = Consult.answered.count
    @fbx_neos_today = Consult.where(consult_type: "fbx_neo", created_at: today).count
  end
end
