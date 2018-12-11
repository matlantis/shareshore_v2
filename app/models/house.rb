class House < ApplicationRecord
  has_many :locations, dependent: :nullify
  reverse_geocoded_by :latitude, :longitude

  private
  def has_no_locations?
    locations.count == 0
  end
end
