class Search < ApplicationRecord
  belongs_to :location, optional: true

  geocoded_by :address
  before_validation :geocode, unless: :use_location

  validates :latitude, presence: { message: "The address could not be found" }, unless: :use_location
  validates :longitude, presence: { message: "The address could not be found" }, unless: :use_location

  validates :use_location, inclusion: { in: [true, false] }
  validates :location, presence: true, if: :use_location
  validates :transport, inclusion: {in: SearchesHelper::TransportModel.list_transport_models}

  after_initialize :init

  def init
    self.transport ||= SearchesHelper::TransportModel.list_transport_models[1] # choose bike
  end

  def self.articles_per_page
    100
  end

  def self.locations_per_page
    20
  end
end
