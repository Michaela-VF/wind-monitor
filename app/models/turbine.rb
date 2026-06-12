class Turbine < ApplicationRecord
  has_many :readings
  has_many :alerts
end
