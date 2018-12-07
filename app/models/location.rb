class Location < ApplicationRecord
  has_many :articles, inverse_of: :location, dependent: :destroy
  belongs_to :user
  belongs_to :house, optional: true
  has_many :searches, dependent: :nullify

  geocoded_by :address   # can also be an IP address
  before_validation :re_geocode, :if => :should_re_geocode?  # auto-fetch coordinates

  validates :latitude, presence: { message: "The address could not be found" }
  validates :longitude, presence: { message: "The address could not be found" }

  before_save :joinhouse
  after_save :clean_houses
  after_destroy :clean_houses

  after_initialize :init

  def init
    # self.country ||= "DE" # make a good guess in the controller
  end

  def should_re_geocode?
    attrs = %w(address)
    attrs.any?{|a| send "#{a}_changed?"}
  end

  def re_geocode
    self.longitude = 0.0
    self.latitude = 0.0
    geocode
  end

  protected
  def joinhouse
    houses = House.near(self, 0.005) # should mean 10 meters
    if ( houses.length > 0)
      self.house = houses.first
    else # or create a new house with a normalized address
      house = House.create({address: address, longitude: longitude, latitude: latitude})
      self.house = house
    end
  end

  protected
  def clean_houses
    print "clean houses"
    House.all.each do |h|
      h.destroy if h.locations.count == 0
    end
  end
end
