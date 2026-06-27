class DashboardController < ApplicationController
  def index
    @turbine_count = Turbine.count
    @reading_count = Reading.count
    @active_alerts = Alert.where(resolved: false).count
    @resolved_alerts = Alert.where(resolved: true).count
  end
end
