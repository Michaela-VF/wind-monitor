
class AlertService
  def self.check_for_alert(reading)
    return unless reading.wind_speed > 8 &&
                  reading.power_output < 0.5

    return if Alert.exists?(
      turbine: reading.turbine,
      resolved: false
    )

    Alert.create!(
      turbine: reading.turbine,
      message: "Low power output despite strong wind",
      resolved: false
    )
  end
end
