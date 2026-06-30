class DashboardController < ApplicationController
  def index
    @turbine_count = Turbine.count
    @reading_count = Reading.count
    @active_alerts = Alert.where(resolved: false).count
    @resolved_alerts = Alert.where(resolved: true).count

    render json: {
      turbine_count: @turbine_count,
      reading_count: @reading_count,
      active_alerts: @active_alerts,
      resolved_alerts: @resolved_alerts
  }
  end
end
