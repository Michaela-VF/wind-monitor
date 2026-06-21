class Reading < ApplicationRecord
  belongs_to :turbine

  validates :turbine_id, presence: true
  validates :wind_speed, presence: true
  validates :power_output, presence: true

  # Simple logic for the purposes of this app,
  # background reading:
  # https://www.mdpi.com/1996-1073/13/4/891, and
  # IEC 61400-12-1 standard: https://webstore.iec.ch/en/publication/68499
end
