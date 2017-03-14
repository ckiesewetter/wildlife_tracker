class Animal < ApplicationRecord
  has_many :sightings

  validates :common_name, :latin_name, :kingdom, presence: true
end
