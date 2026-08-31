class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

def index
  consults = Consult.includes(:asked_by, :assigned_to, :consult_assignments)
                    .where(created_at: 30.days.ago.beginning_of_day..)
                    .order(created_at: :desc)

  @consults_by_date = consults.group_by { |c| c.created_at.in_time_zone.to_date }

  today = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
  @total_today    = Consult.where(created_at: today).count
  @fbx_neos_today = Consult.where(consult_type: "fbx_neo", created_at: today).count
end
end
