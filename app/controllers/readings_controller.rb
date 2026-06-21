class ReadingsController < ApplicationController
  def index
    readings = Reading.all

    render json: readings
  end

  def create
    reading = Reading.new(reading_params)

    if reading.save
      AlertService.check_for_alert(reading)
      render json: reading, status: :created
    else
      render json: reading.errors.full_messages, status: :unprocessable_entity
      # TODO: error handling - Consistent throughout the app:
      # +  user friendly/intuitional
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:turbine_id, :wind_speed, :power_output)
  end
end
