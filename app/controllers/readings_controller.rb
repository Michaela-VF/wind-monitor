class ReadingsController < ApplicationController

  def index
    readings = Reading.all

    render json: readings
  end

  def create
    reading = Reading.new(reading_params)

    if reading.save
      render json: reading, status: :created
    else
      render json: reading.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def reading_params
    params.require(:reading).permit(:turbine_id, :wind_speed, :power_output)
  end
end


