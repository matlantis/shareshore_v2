class Search < ActiveRecord::Base
  belongs_to :location

  geocoded_by :address
  before_validation :geocode, unless: :use_location

  validates :latitude, presence: { message: "The address could not be found" }, unless: :use_location
  validates :longitude, presence: { message: "The address could not be found" }, unless: :use_location
  
  validates :location, presence: true, if: :use_location
  validates :radius, numericality: { greater_than_or_equal_to: 0 }
  
end
