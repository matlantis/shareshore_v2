class House < ApplicationRecord
  has_many :locations, dependent: :nullify
  reverse_geocoded_by :latitude, :longitude

  # self destroy if nobody there (seems not to work)
  after_validation :destroy, on: :update, if: :has_no_locations?

  private
  def has_no_locations?
    locations.count == 0
  end
end
