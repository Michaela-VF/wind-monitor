class AlertsController < ApplicationController
  def index
    render json: Alert.all.order(created_at: :desc)
  end

  def update
    alert = Alert.find(params[:id])

    alert.update!(resolved: true)

    render json: alert
  end
end
