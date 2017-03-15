class Sighting < ApplicationRecord
  belongs_to :animal

  validates :date, :time, :region, :animal, :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true
end
