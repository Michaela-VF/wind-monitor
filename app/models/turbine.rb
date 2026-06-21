class Turbine < ApplicationRecord
  has_many :readings
  has_many :alerts

  validates :name, presence: true
end
