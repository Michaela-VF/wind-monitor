class Reading < ApplicationRecord
  belongs_to :turbine

  after_create :check_for_alert

  private
  # Simple logic for the purposes of this app,
  # background reading:
  # https://www.mdpi.com/1996-1073/13/4/891, and
  # IEC 61400-12-1 standard: https://webstore.iec.ch/en/publication/68499
  def check_for_alert
    return unless wind_speed > 8 && power_output < 0.5

    Alert.create!(
      turbine: turbine,
      message: "Low power output despite strong wind",
      resolved: false
    )
  end
end
